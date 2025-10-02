function plo --wraps='uv pip list --outdated'
  if using uv
    uv pip list --outdated $argv
  else 
    pip list --outdated $argv
  end
end
