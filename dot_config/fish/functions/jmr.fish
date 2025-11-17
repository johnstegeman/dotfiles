function jmr --description 'set up jj repo with multiple remotes'

   # Fetch from both remotes by default
   jj config set --repo git.fetch '["upstream", "origin"]'

   # Push only to the fork by default
   jj config set --repo git.push origin

   # Track both remote bookmarks
   jj bookmark track main@upstream main@origin

   # The upstream repository defines the trunk
   jj config set --repo 'revset-aliases."trunk()"' main@upstream

end