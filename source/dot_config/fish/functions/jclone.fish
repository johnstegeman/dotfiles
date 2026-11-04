function jclone --description "Clone an existing remote into a git-free wrapper (jj + dojjo + beads)"
    # usage: jclone <remote-uri> <directory>
    #   <directory>      created here (jj makes it), e.g. a repo's name
    #   <remote-uri>     a repo WITH history (e.g. git@github.com:you/thing.git)
    #
    # gclone's counterpart for a repo that has no git layer at all -- the state
    # pi-rex is being taken to -- and the same END STATE jinit builds from
    # nothing, reached from the other direction:
    #   <dir>/.jj      ONE jj repo for the whole wrapper, and no .git anywhere
    #   <dir>/main     the base workspace, at the remote's history
    #   <dir>/         the `default` workspace, sparse-cleared and parked on root()
    #   <dir>/.beads   embedded Dolt db at the wrapper root, RECOVERED from
    #                  origin's refs/dolt/data (not created)
    #
    # Order matters, for the same reasons ginit's and jinit's do, and for one
    # that is jclone's alone:
    #   * the wrapper is told to ignore everything BEFORE the first jj command
    #     run from it, because the `default` workspace's working copy is this
    #     very directory and the clone has just materialized the repo's files
    #     into it: whatever is not ignored when jj snapshots the wrapper ends up
    #     in a commit the sparse-clear then deletes from disk;
    #   * main is added BEFORE the sparse-clear, because a new workspace INHERITS
    #     the current workspace's sparse patterns and main has to inherit the
    #     full set;
    #   * the default workspace is never forgotten, only cleared: a forgotten
    #     default is RESURRECTED by any stray jj command run from a non-workspace
    #     directory, junk-snapshotting the wrapper;
    #   * every beads step runs AFTER the clear (the gclone caveat, verified the
    #     hard way: a wrapper file written before it is snapshotted into the
    #     default's commit and then dematerialized), and INSIDE that step the
    #     .beads/config.yaml comes BEFORE `bd bootstrap` -- see the comment
    #     there, it is exactly the opposite of gclone's order.

    if test (count $argv) -ne 2
        echo "usage: jclone <remote-uri> <directory>" >&2
        return 1
    end

    set -l remote $argv[1]
    set -l name $argv[2]

    # Dolt remotes want the git+ssh form; normalize the ssh forms
    # (git@host:owner/repo.git and ssh://git@host/owner/repo.git both become
    # git+ssh://git@host/owner/repo.git). Other forms pass through unchanged.
    set -l dolt_remote (string replace -r '^git@([^:]+):(.*)$' 'git+ssh://git@$1/$2' $remote)
    set dolt_remote (string replace -r '^ssh://' 'git+ssh://' -- $dolt_remote)

    # 1. the clone, with NO git layer: `--no-colocate` is the whole point of
    #    jclone (jj 0.47.1 takes it; if a later version stops, clone into a
    #    scratch directory and point a fresh wrapper at it with
    #    `jj git init --no-colocate` + `jj git remote add` + `jj git fetch`).
    #    The destination is jj's to create -- no `take` first: jj refuses a
    #    directory that is already there, and a clone that fails then leaves
    #    nothing of ours behind to clean up.
    command jj git clone --no-colocate $remote $name
    or return 1
    builtin cd "$name"
    or return 1
    set -l wrapper (pwd)

    # 2. everything in this directory is ignored, and this is the FIRST thing
    #    done inside it. The `default` workspace's working copy IS this
    #    directory, and the clone has just materialized the repo's files here:
    #    the workspace add and the sparse-clear below both snapshot it first,
    #    so an UNTRACKED file that appears in this window is captured -- into a
    #    commit the clear then dematerializes, i.e. deletes from disk (checked:
    #    a .beads written before the clear without this line is gone after it).
    #    Nothing of jclone's own is written before the clear -- the beads block
    #    comes after it -- so this is the belt to that order's suspenders, and
    #    it is what jinit and gclone both do. Overwriting the repo's own
    #    (tracked) .gitignore costs nothing: the clear dematerializes that too,
    #    and `main` keeps its own copy.
    printf '*\n' >.gitignore
    or return 1

    # 3. main FIRST, and before the sparse-clear: a new workspace INHERITS the
    #    sparse patterns of the workspace it is added from, so an add after the
    #    clear would hand main the empty pattern set -- a main whose working copy
    #    sees no files at all. The "workspace created inside the current
    #    directory" warning here is expected and benign.
    command jj workspace add --name main main
    or return 1

    # 4. the default workspace's working copy is the wrapper directory itself --
    #    left full it would snapshot main/ and .beads/ as junk. Do NOT forget it:
    #    a forgotten default gets RESURRECTED by any stray jj command run from a
    #    non-workspace directory, junk-snapshotting the wrapper. Instead make it
    #    inert: sparse-clear it (snapshots see nothing, and the clone's files are
    #    dematerialized out of the wrapper) and reparent its @ onto the root
    #    commit.
    command jj sparse set --clear
    or return 1
    # NOTE: root() MUST be quoted -- fish treats (…) as command substitution.
    # It is NOT forgiven with `or true` the way gclone forgives it: gclone has a
    # colocated git worktree to fall back on, and this function does not -- a
    # default left parked where it was is a default that snapshots the wrapper
    # the first time a stray jj command runs from here.
    command jj new "root()" -m 'default workspace: intentionally empty (see jclone)'
    or return 1

    # 5. beads, recovered rather than created -- and ALL of it after the clear
    #    above, because any wrapper file written before it is either snapshotted
    #    into the default's commit or deleted by the clear (gclone's caveat,
    #    verified the hard way). Run from the wrapper root because that is the
    #    layout the flow reads (.beads beside main, found by upward detection
    #    from whichever workspace is asking).
    #
    #    The CONFIG comes first, and that is jclone's own ordering rule: with no
    #    .git anywhere, `bd bootstrap` has no git origin to look for
    #    refs/dolt/data on, and answers "No active beads workspace found" --
    #    a sync.remote in .beads/config.yaml is the only thing that tells it
    #    where the database lives. gclone could bootstrap first because its
    #    wrapper still had a .git; this one cannot.
    mkdir -p .beads
    printf 'sync:\n    remote: "%s"\n' $dolt_remote >.beads/config.yaml
    or return 1

    command bd bootstrap --yes
    or return 1
    # belt and suspenders: verify the database landed HERE -- a recovery that
    # answered 0 without writing a db (or an ancestor's .beads adopted instead)
    # must fail loudly here rather than leave a wrapper the flow cannot read.
    if not test -d "$wrapper/.beads/embeddeddolt"
        echo "jclone: bd bootstrap did not create $wrapper/.beads/embeddeddolt" >&2
        echo "  nothing was recovered — does origin carry refs/dolt/data?" >&2
        return 1
    end
    # bd bootstrap recovers the db under the default name "beads" and writes
    # this file itself on the clone-from-remote path; it is pinned here anyway
    # so the recovered database's name does not depend on WHICH bootstrap path
    # ran. `bd dolt set database` is server-mode-only, and `bd init
    # --init-if-missing` would mint a NEW db named after the cwd and orphan the
    # recovered one (the pi-rex-incident damage class — tested).
    printf '{\n  "database": "dolt",\n  "backend": "dolt",\n  "dolt_mode": "embedded",\n  "dolt_database": "beads"\n}\n' >.beads/metadata.json
    or return 1
    # 700 because the db holds issues and is not for everyone to read -- and set
    # once, here, after everything that writes under .beads: `bd bootstrap`
    # makes directories of its own in there, so this is the last word on it.
    command chmod 700 .beads
    or return 1

    # 6. the window title, as gclone ends: this wrapper is now the repo it was
    #    cloned from, and the person is about to work in it. A rex that is not
    #    installed is cosmetic and does not turn a good clone into a failed one,
    #    but a rex that IS installed and refuses is worth one line: the window is
    #    left mis-titled, and swallowing its complaint hides the only report of
    #    why. So the name is asked for first, and the failure stays on screen
    #    while the clone itself still exits 0.
    builtin cd "$wrapper/main"
    or return 1
    if command -q rex
        command rex window rename main
        or true
    end
end
