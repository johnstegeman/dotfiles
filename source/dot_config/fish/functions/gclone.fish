function gclone --description "Clone a worktrunk+beads+jj repo into the wrapper layout (ginit's counterpart for existing repos)"
    # usage: gclone <remote-uri> <directory>
    #
    # Same end state as ginit: bare .git at the wrapper, .beads at the wrapper
    # root (recovered from origin's refs/dolt/data via bd bootstrap), main as a
    # COLOCATED JJ WORKSPACE of the directory-level jj repo.
    #
    # Differences from ginit: the repo has history (no orphan seed needed), the
    # hooks config comes from the cloned repo (no seeding), and .beads already
    # exists BEFORE the jj steps — see the jj block for why that matters.

    # normalize the ssh short form for the Dolt/sync remote (same as ginit)
    set -l dolt_remote (string replace -r '^git@([^:]+):(.*)$' 'git+ssh://git@$1/$2' $argv[1])

    take $argv[2]
    git clone --bare $argv[1] .git

    git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

    git fetch origin

    git remote set-head origin --auto

    git worktree add -b chore/setup setup

    cd setup

    bd bootstrap --yes

    cd ..

    chmod 700 .beads


    git worktree remove setup

    git branch -d chore/setup

    # jj: directory-level repo backed by the bare .git (ginit v8 construction).
    # jj git init MATERIALIZES the seed tree at the wrapper — including the
    # repo's own .gitignore. Overwrite that with '*' so the next command's
    # snapshot cannot absorb .beads (robust even for repos whose own
    # .gitignore lacks a .beads/ line); sparse --clear later dematerializes
    # everything, leaving the wrapper clean.
    jj git init --git-repo .git .
    or return 1
    echo '*' >.gitignore
    # main as a colocated workspace of the directory repo (inherits default's
    # full sparse patterns; the add snapshots before main/ exists, so it sees
    # only the ignored wrapper)
    jj workspace add --colocate main
    or return 1
    # make the default workspace inert — never FORGET it (a forgotten default
    # resurrects on stray jj commands from non-workspace dirs and
    # junk-snapshots the wrapper). The clear also dematerializes the seed
    # files jj placed at the wrapper.
    # NOTE: root() must be quoted — fish treats (…) as command substitution
    jj sparse set --clear
    or return 1
    jj new "root()" -m 'default workspace: intentionally empty (see gclone)'
    or true

    # bd bootstrap recovers the db under the default name "beads" but writes
    # NO .beads/config.yaml or metadata.json — bd then warns "no beads
    # configuration found" on every command. Write them directly, pointing at
    # "beads": `bd dolt set database` is server-mode-only, and `bd init
    # --init-if-missing` would mint a NEW db named after the cwd and orphan
    # the recovered one (the pi-rex-incident damage class — tested). MUST run
    # AFTER the jj block: the default workspace's snapshot absorbs wrapper
    # files until it is sparse-cleared, and `jj sparse set --clear` then
    # dematerializes (deletes) them — verified the hard way.
    printf '{\n  "database": "dolt",\n  "backend": "dolt",\n  "dolt_mode": "embedded",\n  "dolt_database": "beads"\n}\n' >.beads/metadata.json
    printf 'sync:\n    remote: "%s"\n' $dolt_remote >.beads/config.yaml

    # the original gclone relied on `wt switch main` cd-ing into main (shell
    # integration) — be explicit about it
    cd main

    # main already exists as a branch from the clone — attach, don't create
    git checkout main
    or return 1
    wt -y hook post-start

    git branch --set-upstream-to=origin/main main

    # keep the local main bookmark updated from origin on future pulls
    jj bookmark track main@origin 2>/dev/null
    or true

    rex window rename main
end
