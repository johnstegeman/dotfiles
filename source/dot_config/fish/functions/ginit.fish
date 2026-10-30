function ginit --description "Initialize a new worktrunk + jj + beads repo from an empty GitHub remote (gclone analog for fresh repos)"
    # usage: ginit <directory> <git-remote-uri>
    #   <directory>     created under the current directory
    #   <git-remote-uri>  assumed to be a plain, EMPTY repo (e.g. git@github.com:you/pi-rex.git)
    #
    # Produces the wrapper layout (verified 2026-11-02, see
    # pi-packages docs/redevelopment/02-vcs-considerations.md section 7):
    #   <dir>/.git     bare repo, origin = the remote, HEAD on main
    #   <dir>/main     worktree (created by wt, post-start hooks committed first)
    #   <dir>/.beads   embedded Dolt db at the wrapper root; dolt remote = the gh repo
    #   <dir>/main     jj colocated (jj git init --colocate)
    #
    # Order matters: the seed commit (gitignore, worktreeinclude, wt post-start
    # hooks) must exist BEFORE `wt switch main` so the main worktree gets the
    # hooks; beads init runs from the wrapper root so the id prefix is the repo
    # name; the git push happens while HEAD is still attached; jj colocates last.

    if test (count $argv) -ne 2
        echo "usage: ginit <directory> <git-remote-uri>   (remote is assumed to be a plain, empty repo)" >&2
        return 1
    end

    set -l name $argv[1]
    set -l remote $argv[2]

    # Dolt remotes want the git+ssh form; normalize the ssh short form
    # (git@host:owner/repo.git -> git+ssh://git@host/owner/repo.git). Other
    # forms pass through unchanged.
    set -l dolt_remote (string replace -r '^git@([^:]+):(.*)$' 'git+ssh://git@$1/$2' $remote)

    take $name
    or return 1
    set -l wrapper (pwd)

    # refuse to nest inside another beads workspace: bd init would adopt the
    # parent database (re-initializing it under a new prefix) instead of
    # creating a fresh one here — verified the hard way 2026-11-03
    set -l ancestor (dirname $wrapper)
    while test "$ancestor" != "/"
        # a REAL workspace (db or metadata) — ~/.beads holds only bd's global
        # state (formulas, machine-id) and must not trigger this
        if test -d "$ancestor/.beads/embeddeddolt"; or test -f "$ancestor/.beads/metadata.json"
            echo "ginit: refusing to run inside another beads workspace" >&2
            echo "  found: $ancestor/.beads — bd init would adopt that database" >&2
            echo "  run ginit from a directory whose ancestors have no .beads" >&2
            cd ..
            rmdir $name 2>/dev/null
            return 1
        end
        set ancestor (dirname $ancestor)
    end

    # 1. bare repo at .git, HEAD on main, origin pointed at the remote
    git init --bare -b main .git
    or return 1
    git -C .git remote add origin $remote

    # 2. seed commit on an orphan worktree (needs git >= 2.42)
    git worktree add --orphan -b chore/setup $wrapper/setup
    or return 1
    cd setup
    printf '# %s\n' $name >README.md
    printf '%s\n' .env .worktrees/ .beads/ >.gitignore
    printf '%s\n' '.env*' >.worktreeinclude
    mkdir -p .config
    # no beads-redirect hook: in the wrapper layout bd's upward detection
    # finds the wrapper-root .beads from any worktree (pi-packages model);
    # a worktree .beads/redirect would be untracked noise — and jj would
    # snapshot it into @
    printf '%s\n' \
        '[post-start]' \
        'copy = "wt step copy-ignored --require-include"' \
        '[post-remove]' \
        'jj = "jj workspace forget {{ branch }} 2>/dev/null || true"' \
        >.config/wt.toml
    git add -A
    git commit -qm "seed: README, gitignore, worktreeinclude, worktrunk post-start hooks"
    or return 1
    cd $wrapper
    git worktree remove setup
    git branch main chore/setup
    git branch -d chore/setup

    # 3. jj: ONE repo per directory, anchored at the wrapper and backed by
    #    the wrapper's .git — main becomes a COLOCATED WORKSPACE of it (not an
    #    independent per-worktree repo). Future worktrees join the same repo
    #    via `jj workspace add --colocate $wrapper/<name>`.
    cd $wrapper
    jj git init --git-repo .git .
    or return 1
    # main FIRST: a colocated git worktree + jj workspace of the directory
    # repo (the nested-workspace warning here is expected and benign — the
    # default workspace is forgotten immediately after, before it ever
    # snapshots anything; forgetting BEFORE the add does not stick — jj
    # recreates a default when no current workspace exists)
    jj workspace add --colocate main
    or return 1
    # the default workspace's working copy is the wrapper dir itself — left
    # full it would snapshot every sibling worktree as junk. Do NOT forget
    # it: a forgotten default gets RESURRECTED by any stray jj command run
    # from a non-workspace dir (e.g. a plain git worktree), junk-snapshotting
    # the wrapper. Instead make it inert: sparse-clear it (snapshots see
    # nothing) and reparent its @ onto the root commit. Order matters: this
    # runs AFTER `workspace add main` — new workspaces inherit the current
    # workspace's sparse patterns, and main must inherit the full set.
    jj sparse set --clear
    or return 1
    # NOTE: root() MUST be quoted — fish treats (…) as command substitution
    jj new "root()" -m 'default workspace: intentionally empty (see ginit)'
    or true
    git -C main checkout main
    or return 1
    # jj (not wt) created the worktree, so wt's post-start hooks did not
    # run — run them manually (idempotent): copy-ignored
    wt -C $wrapper/main -y hook post-start

    # 4. initial push + upstream wiring (while HEAD is still attached)
    cd $wrapper/main
    git push -u origin main
    or return 1
    git remote set-head origin --auto

    # 5. beads at the wrapper root: fresh db (prefix = repo name), dolt remote
    #    on the gh repo, initial dolt push. bd init also derives
    #    .beads/config.yaml sync.remote from git origin automatically.
    cd $wrapper
    bd init --skip-hooks --skip-agents
    or return 1
    # belt and suspenders: verify the db landed HERE before any remote/push step
    if not test -d "$wrapper/.beads/embeddeddolt"
        echo "ginit: bd init did not create $wrapper/.beads — a parent workspace was" >&2
        echo "  adopted. Nothing was pushed; investigate before re-running." >&2
        return 1
    end
    chmod 700 .beads
    # --allow-git-origin: the dolt remote deliberately matches git origin —
    # the monorepo layout (dolt data lives in the same repo as the code, like
    # pmm-iris: refs/dolt/data on the gh repo)
    bd dolt remote add origin $dolt_remote --allow-git-origin
    or return 1
    bd dolt push
    or return 1

    # 6. associate the local main bookmark with its remote counterpart (jj's
    #    own post-init hint) so future pulls keep it updated
    cd $wrapper/main
    jj bookmark track main@origin 2>/dev/null
    or true

    echo ""
    echo "ginit: $wrapper is ready"
    echo "  worktree:    $wrapper/main (colocated jj workspace of the directory repo, HEAD on main)"
    echo "  git remote:  $remote (main pushed)"
    echo "  dolt remote: $dolt_remote (initial bd dolt push done)"
    echo "next: cd $name/main — add feature worktrees with: gws <name>"
    echo "      remove them with: wt remove <name>  (hooks keep jj in sync both ways)"
    echo "      each repo has its own beads db (dolt remote = its gh repo);"
    echo "      fresh clones recover issues via 'bd bootstrap' (gclone flow)"
end
