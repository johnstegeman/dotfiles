function jinit --description "Initialize a fresh wrapper from an empty remote with no git layer (jj + dojjo + beads)"
    # usage: jinit <directory> <git-remote-uri>
    #   <directory>      created under the current directory
    #   <git-remote-uri> assumed to be a plain, EMPTY repo (e.g. git@github.com:you/thing.git)
    #
    # ginit's counterpart for a repo that has no git layer at all -- the state
    # pi-rex is being taken to. Produces:
    #   <dir>/.jj      ONE jj repo for the whole wrapper, and no .git anywhere
    #   <dir>/main     the base workspace: the seed commit, full sparse patterns
    #   <dir>/         the `default` workspace, sparse-cleared and parked on root()
    #   <dir>/.beads   embedded Dolt db at the wrapper root; dolt remote = the gh repo
    #
    # Order matters, for the same reasons ginit's does, and for two of its own:
    #   * the seed commit (README, gitignore, worktreeinclude, hook config) must
    #     exist BEFORE anything is created from main, or a workspace made here
    #     starts without the hook config jws runs;
    #   * main is added BEFORE the sparse-clear, because a new workspace INHERITS
    #     the current workspace's sparse patterns and main has to inherit the
    #     full set;
    #   * the default workspace is never forgotten, only cleared: a forgotten
    #     default is RESURRECTED by any stray jj command run from a non-workspace
    #     directory, junk-snapshotting the wrapper;
    #   * beads init runs from the wrapper root (prefix = repo name) and only
    #     AFTER the default workspace is inert, because bd writes .beads/ and its
    #     lock files into this very directory.

    if test (count $argv) -ne 2
        echo "usage: jinit <directory> <git-remote-uri>   (remote is assumed to be a plain, empty repo)" >&2
        return 1
    end

    set -l name $argv[1]
    set -l remote $argv[2]

    # Dolt remotes want the git+ssh form; normalize the ssh forms
    # (git@host:owner/repo.git and ssh://git@host/owner/repo.git both become
    # git+ssh://git@host/owner/repo.git). Other forms pass through unchanged.
    set -l dolt_remote (string replace -r '^git@([^:]+):(.*)$' 'git+ssh://git@$1/$2' $remote)
    set dolt_remote (string replace -r '^ssh://' 'git+ssh://' -- $dolt_remote)

    take $name
    or return 1
    set -l wrapper (pwd)

    # refuse to nest inside another beads workspace: bd init would adopt the
    # parent database (re-initializing it under a new prefix) instead of
    # creating a fresh one here — verified the hard way 2026-11-03
    set -l ancestor (command dirname $wrapper)
    while test "$ancestor" != "/"
        # a REAL workspace (db or metadata) — ~/.beads holds only bd's global
        # state (formulas, machine-id) and must not trigger this
        if test -d "$ancestor/.beads/embeddeddolt"; or test -f "$ancestor/.beads/metadata.json"
            echo "jinit: refusing to run inside another beads workspace" >&2
            echo "  found: $ancestor/.beads — bd init would adopt that database" >&2
            echo "  run jinit from a directory whose ancestors have no .beads" >&2
            # give back the one thing this run made: the directory `take` created
            builtin cd ..
            command rmdir "$wrapper" 2>/dev/null
            return 1
        end
        set ancestor (command dirname $ancestor)
    end

    # 1. the wrapper repo: a .jj and NO .git anywhere (`--no-colocate` is the
    #    whole point of jinit). The `.gitignore` covers everything, so that any
    #    jj command run from this directory BEFORE the default workspace is
    #    cleared -- the workspace add below, and the clear itself -- cannot
    #    snapshot main/ (and, later, .beads/) into the default's working copy.
    #    It costs nothing after that: a cleared default sees no files at all.
    command jj git init --no-colocate .
    or return 1
    printf '*\n' >.gitignore

    # 2. main FIRST, and before the sparse-clear: a new workspace INHERITS the
    #    sparse patterns of the workspace it is added from, so an add after the
    #    clear would hand main the empty pattern set -- a main whose working copy
    #    sees no files at all. The "workspace created inside the current
    #    directory" warning here is expected and benign.
    command jj workspace add --name main main
    or return 1

    # 3. the default workspace's working copy is the wrapper directory itself —
    #    left full it would snapshot main/ and .beads/ as junk. Do NOT forget it:
    #    a forgotten default gets RESURRECTED by any stray jj command run from a
    #    non-workspace directory, junk-snapshotting the wrapper. Instead make it
    #    inert: sparse-clear it (snapshots see nothing) and reparent its @ onto
    #    the root commit.
    command jj sparse set --clear
    or return 1
    # NOTE: root() MUST be quoted — fish treats (…) as command substitution.
    # It is NOT forgiven with `or true` the way ginit forgives it: ginit has a
    # colocated git worktree to fall back on, and this function does not -- a
    # default left parked where it was is a default that snapshots the wrapper
    # the first time a stray jj command runs from here.
    command jj new "root()" -m 'default workspace: intentionally empty (see jinit)'
    or return 1

    # 4. the seed commit, IN main and BEFORE any workspace is created from it: a
    #    workspace made from main inherits main's content, and everything after
    #    this (jws, the tab, the done flow) expects the hook config to be here.
    builtin cd "$wrapper/main"
    or return 1
    printf '# %s\n' $name >README.md
    printf '%s\n' .env .worktrees/ .beads/ >.gitignore
    # .worktreeinclude is seeded EMPTY, on purpose. ginit seeds one, so a wrapper
    # made by jinit has the same four files and nothing has to special-case a
    # missing one; but dojjo is not worktrunk: `djo copy-ignored` reads this file
    # as a LITERAL include list with no globbing at all, and a line that matches
    # nothing turns the copy hook OFF (it copies nothing rather than everything).
    # ginit's `.env*` is exactly such a line under dojjo. An empty file yields no
    # lines, so nothing is filtered and every ignored path comes across -- the
    # behaviour the owner accepted. `printf ''`, not a line: zero bytes is what
    # `djo` reads as "no filter".
    printf '' >.worktreeinclude
    mkdir -p .config
    # `[hooks.post-start]`, never worktrunk's top-level `[post-start]`: dojjo
    # reads the table form, and a config it half-reads is worse than none at all
    # (the hooks then silently never run). The copy hook passes no include flag:
    # dojjo has none, and the empty .worktreeinclude above is what leaves its
    # literal filter with nothing to match against -- so everything git-ignored
    # comes along (node_modules with .env), which the owner accepted. There is no
    # beads-redirect hook: in the wrapper layout bd's upward detection finds the
    # wrapper-root .beads from any workspace, and a committed .beads/redirect
    # would be untracked noise jj would snapshot.
    printf '%s\n' \
        '[hooks.post-start]' \
        'copy = "djo copy-ignored --from main"' \
        >.config/wt.toml
    command jj commit -m 'seed: README, gitignore, worktreeinclude, hooks'
    or return 1

    # 5. remote and history: the fetch first, so jj knows what origin holds
    #    before this repo creates `main` for itself -- on the empty remote jinit
    #    assumes, it is a no-op. `main` is the seed commit `jj commit` just
    #    left behind (@-), not the empty working copy on top of it.
    command jj git remote add origin $remote
    or return 1
    command jj git fetch
    or return 1
    command jj bookmark create main -r @-
    or return 1
    command jj git push --bookmark main
    or return 1
    # associate the local main bookmark with its remote counterpart (jj's own
    # post-push hint) so future fetches keep it updated. This jj tracks a pushed
    # bookmark by itself, so "already tracked" is the expected answer -- and its
    # absence is not a failure either: the bookmark is pushed and working.
    command jj bookmark track main@origin 2>/dev/null
    or true

    # 6. beads at the wrapper root: fresh db (prefix = repo name), dolt remote on
    #    the gh repo, initial dolt push. Run from the wrapper because that is the
    #    layout every other part of the flow reads (.beads beside main, found by
    #    upward detection from whichever workspace is asking).
    builtin cd "$wrapper"
    or return 1
    command bd init --skip-hooks --skip-agents
    or return 1
    # belt and suspenders: verify the db landed HERE before any remote/push step
    if not test -d "$wrapper/.beads/embeddeddolt"
        echo "jinit: bd init did not create $wrapper/.beads — a parent workspace was" >&2
        echo "  adopted. Nothing was pushed; investigate before re-running." >&2
        return 1
    end
    # bd init makes itself a git repo when it cannot find one ("Initialized git
    # repository") and offers no switch to stop it. That repo is empty and holds
    # nothing this wrapper needs: dolt pushes its data straight to the remote URL,
    # and nothing else in the flow reads .git. It goes, because a .git at the
    # wrapper is exactly what jinit exists to keep out -- and bd keeps working
    # without it (the db is found by walking up to .beads, not through git).
    # If it survives, this run has failed: say so rather than print
    # "is ready" over a wrapper with a git layer in it.
    command rm -rf "$wrapper/.git"
    if test -e "$wrapper/.git"
        echo "jinit: could not remove $wrapper/.git — this wrapper must have no" >&2
        echo "  git layer. Nothing was pushed; remove it and re-run." >&2
        return 1
    end
    command chmod 700 .beads
    or return 1
    # --allow-git-origin: the dolt remote deliberately matches git origin —
    # the monorepo layout (dolt data lives in the same repo as the code, like
    # pmm-iris: refs/dolt/data on the gh repo). Note that with the .git above
    # removed there is no git origin left to compare against, so on THIS path
    # the flag is decorative: bd is not enforcing the sameness for us, the
    # comment is the only record of the intent.
    command bd dolt remote add origin $dolt_remote --allow-git-origin
    or return 1
    command bd dolt push
    or return 1

    echo ""
    echo "jinit: $wrapper is ready"
    echo "  workspace:   $wrapper/main (jj workspace 'main', no git layer anywhere)"
    echo "  git remote:  $remote (main pushed)"
    echo "  dolt remote: $dolt_remote (initial bd dolt push done)"
    echo "next: cd $name/main — create workspaces with: jws <branch>"
    echo "      remove them with: djo remove <branch> -y, or ctrl+space>d"
    echo "      each repo has its own beads db (dolt remote = its gh repo);"
    echo "      fresh clones recover issues via 'bd bootstrap' (jclone flow)"
end
