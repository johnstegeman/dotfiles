function lt
  if using lsd
    lsd --tree $argv
  else
    echo "Error: eza is not installed" >&2
    return 1
  end
end
