function gclone

  take $argv[2]
  git clone --bare $argv[1] .git

  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

  git fetch origin

  git remote set-head origin --auto

  wt switch main

  git branch --set-upstream-to=origin/main main


end
