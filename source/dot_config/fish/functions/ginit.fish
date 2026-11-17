function ginit --description "Initialize a new worktrunk + beads repo from an empty GitHub remote (gclone's counterpart for fresh repos)"

  # usage: ginit <directory> <git-remote-uri>
  #   <directory>      created under the current directory
  #   <git-remote-uri> assumed to be a plain, EMPTY repo (e.g. git@github.com:you/pi-rex.git)
  #
  # Produces the wrapper layout:
  #   <dir>/.git     bare repo, origin = the remote, HEAD on main
  #   <dir>/main     the worktree wt creates for main (so its post-start hooks run)
  #   <dir>/.beads   embedded Dolt db at the wrapper root; dolt remote = the gh repo
  #
  # Worktrees land inside the wrapper because ~/.config/worktrunk/config.toml's
  # worktree-path template is {{ repo_path }}/../{{ branch | sanitize }}, and in a
  # bare-at-the-wrapper repo repo_path is <dir>/.git -- so main is <dir>/main.
  #
  # Directories are entered with `builtin cd`, and the directory is made with
  # mkdir rather than `take`: fish's function namespace belongs to the USER, and on
  # this machine `cd` is a `ze` jumper — `cd main` lands in whatever ze thinks you
  # meant (~/Projects/_pmm/pmm-iris/main, say), not the directory just created.
  #
  # Order matters: the seed commit (README, gitignore, worktreeinclude, the wt
  # post-start copy hook) must exist BEFORE `wt switch main`, so main is created
  # in a repo that already carries the hooks it should run; the push happens with
  # main checked out; beads init runs from the wrapper root so the id prefix is
  # the repo name.

  if test (count $argv) -ne 2
    echo "usage: ginit <directory> <git-remote-uri>   (remote is assumed to be a plain, empty repo)" >&2
    return 1
  end

  set -l name $argv[1]
  set -l remote $argv[2]

  # Dolt remotes want the git+ssh form; normalize the ssh short form
  # (git@host:owner/repo.git -> git+ssh://git@host/owner/repo.git). Other forms
  # pass through unchanged.
  set -l dolt_remote (string replace -r '^git@([^:]+):(.*)$' 'git+ssh://git@$1/$2' $remote)

  mkdir -p $name
  or return 1
  builtin cd $name
  or return 1
  set -l wrapper (pwd)

  # refuse to nest inside another beads workspace: bd init would adopt the parent
  # database (re-initializing it under a new prefix) instead of creating a fresh
  # one here — verified the hard way 2026-11-03
  set -l ancestor (dirname $wrapper)
  while test "$ancestor" != "/"
    # a REAL workspace (db or metadata) — ~/.beads holds only bd's global state
    # (formulas, machine-id) and must not trigger this
    if test -d "$ancestor/.beads/embeddeddolt"; or test -f "$ancestor/.beads/metadata.json"
      echo "ginit: refusing to run inside another beads workspace" >&2
      echo "  found: $ancestor/.beads — bd init would adopt that database" >&2
      echo "  run ginit from a directory whose ancestors have no .beads" >&2
      builtin cd ..
      rmdir $name 2>/dev/null
      return 1
    end
    set ancestor (dirname $ancestor)
  end

  # 1. bare repo at .git, HEAD on main, origin pointed at the remote
  git init --bare -b main .git
  or return 1
  git -C .git remote add origin $remote
  or return 1

  # 2. seed commit on an orphan worktree (needs git >= 2.42)
  git worktree add --orphan -b chore/setup $wrapper/setup
  or return 1
  builtin cd setup
  printf '# %s\n' $name >README.md
  printf '%s\n' .env .worktrees/ .beads/ >.gitignore
  printf '%s\n' '.env*' >.worktreeinclude
  mkdir -p .config
  # no beads-redirect hook: in the wrapper layout bd's upward detection finds the
  # wrapper-root .beads from any worktree, so a worktree .beads/redirect would be
  # untracked noise
  printf '%s\n' \
    '[post-start]' \
    'copy = "wt step copy-ignored --require-include"' \
    >.config/wt.toml
  git add -A
  git commit -qm "seed: README, gitignore, worktreeinclude, worktrunk post-start hooks"
  or return 1
  builtin cd $wrapper
  git worktree remove setup
  or return 1
  git branch main chore/setup
  or return 1
  git branch -d chore/setup

  # 3. main's worktree, made by wt so its post-start hooks run.
  # -y: worktrunk gates project hooks behind an approval prompt, which a
  # non-interactive caller (a test, an agent) cannot answer, and creating a
  # wrapper here is a deliberate act.
  wt -y switch main
  or return 1

  # wt's directory change is shell integration, which only exists in an
  # interactive shell; be explicit so the push runs with main checked out.
  # Absolute, because when the integration IS active wt has already changed there.
  builtin cd $wrapper/main
  or return 1

  # 4. initial push + upstream wiring
  git push -u origin main
  or return 1
  git remote set-head origin --auto

  # 5. beads at the wrapper root: fresh db (prefix = repo name), dolt remote on
  #    the gh repo, initial dolt push. bd init also derives
  #    .beads/config.yaml sync.remote from git origin automatically.
  builtin cd $wrapper
  bd init --skip-hooks --skip-agents
  or return 1
  # belt and suspenders: verify the db landed HERE before any remote/push step
  if not test -d "$wrapper/.beads/embeddeddolt"
    echo "ginit: bd init did not create $wrapper/.beads — a parent workspace was" >&2
    echo "  adopted. Nothing was pushed; investigate before re-running." >&2
    return 1
  end
  chmod 700 .beads
  # --allow-git-origin: the dolt remote deliberately matches git origin — the
  # monorepo layout (dolt data lives in the same repo as the code, like
  # pmm-iris: refs/dolt/data on the gh repo)
  bd dolt remote add origin $dolt_remote --allow-git-origin
  or return 1
  bd dolt push
  or return 1

  echo ""
  echo "ginit: $wrapper is ready"
  echo "  worktree:    $wrapper/main (HEAD on main)"
  echo "  git remote:  $remote (main pushed)"
  echo "  dolt remote: $dolt_remote (initial bd dolt push done)"
  echo "next: cd $name/main — create worktrees with: wt switch --create <branch>"
  echo "      remove them with: wt remove <branch>"
  echo "      each repo has its own beads db (dolt remote = its gh repo);"
  echo "      fresh clones recover issues via 'bd bootstrap' (gclone flow)"
end
