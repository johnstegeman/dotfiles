function jmr --description 'set up jj repo with multiple remotes'
  if not using jj
    echo "Error: jj is not installed" >&2
    return 1
  end

  # Fetch from both remotes by default
  jj config set --repo git.fetch '["upstream", "origin"]'; or return 1

  # Push only to the fork by default
  jj config set --repo git.push origin; or return 1

  # Track both remote bookmarks
  jj bookmark track main@upstream main@origin; or return 1

  # The upstream repository defines the trunk
  jj config set --repo 'revset-aliases."trunk()"' main@upstream; or return 1
end