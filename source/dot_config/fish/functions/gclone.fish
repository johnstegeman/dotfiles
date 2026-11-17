function gclone --description "Clone an existing repo into the worktrunk wrapper layout: bare .git at the wrapper, main created by wt, beads recovered by bd bootstrap"

  # usage: gclone <git-remote-uri> <directory>
  #
  # The wrapper layout: <dir>/.git is a BARE repo whose origin is the remote,
  # <dir>/main is worktrunk's worktree for main, and <dir>/.beads is the beads
  # database, RECOVERED from origin's refs/dolt/data by bd bootstrap (not minted:
  # the issues come with it).
  #
  # Worktrees land inside the wrapper because ~/.config/worktrunk/config.toml's
  # worktree-path template is {{ repo_path }}/../{{ branch | sanitize }}, and in a
  # bare-at-the-wrapper repo repo_path is <dir>/.git — so main is <dir>/main.
  #
  # Differences from ginit: the repo has history (no orphan seed needed) and the
  # hooks config comes from the cloned repo (nothing seeded).
  #
  # Directories are entered with `builtin cd`, and the directory is made with
  # mkdir rather than `take`: fish's function namespace belongs to the USER, and on
  # this machine `cd` is a `ze` jumper — `cd main` lands in whatever ze thinks you
  # meant (~/Projects/_pmm/pmm-iris/main, say), not the sibling directory.

  if test (count $argv) -ne 2
    echo "usage: gclone <git-remote-uri> <directory>" >&2
    return 1
  end

  mkdir -p $argv[2]
  or return 1
  builtin cd $argv[2]
  or return 1

  set -l wrapper (pwd)

  git clone --bare $argv[1] .git
  or return 1

  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

  git fetch origin
  or return 1

  git remote set-head origin --auto

  # a worktree to run bd bootstrap in. Bootstrap recovers the database from the
  # remote's refs/dolt/data and leaves it at the WRAPPER root (bd detects the
  # repository root above the worktree), with metadata.json and a config.yaml
  # whose sync.remote is this repo's git origin — which is also what puts the
  # dolt remote in place.
  git worktree add -b chore/setup setup
  or return 1

  builtin cd setup
  bd bootstrap --yes
  or return 1
  builtin cd ..

  chmod 700 .beads

  git worktree remove setup
  or return 1
  git branch -d chore/setup

  # main already exists as a branch from the clone — wt creates its worktree and
  # runs the project's post-start hooks. -y: worktrunk gates project hooks behind
  # an approval prompt nobody can answer from a script or an agent, and creating a
  # wrapper here is a deliberate act.
  wt -y switch main
  or return 1

  # wt's directory change is shell integration, which only exists in an
  # interactive shell; be explicit so the rest of the function runs inside main.
  # Absolute, because when the integration IS active wt has already changed there.
  builtin cd $wrapper/main
  or return 1

  git branch --set-upstream-to=origin/main main

  rex window rename main
end
