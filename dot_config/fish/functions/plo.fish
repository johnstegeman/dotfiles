function plo --wraps='uv pip list --outdated'
  if using uv
    uv pip list --outdated $argv
  else
    if using pip
      pip list --outdated $argv
    else
      echo "Error: neither uv nor pip is installed" >&2
      return 1
    end
  end
end
