function gclone

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

  wt switch main

  git branch --set-upstream-to=origin/main main

  rex window rename main

end
