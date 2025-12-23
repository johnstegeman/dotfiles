function lt --wraps='eza --tree'
  if using eza
    eza --tree $argv
  else
    echo "Error: eza is not installed" >&2
    return 1
  end
end
