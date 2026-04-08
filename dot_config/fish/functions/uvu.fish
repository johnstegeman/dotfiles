function uvu --wraps='uv lock --upgrade; uv sync' --description 'alias uvu uv lock --upgrade; uv sync'
  if not using uv
    echo "Error: uv is not installed" >&2
    return 1
  end
  uv lock --upgrade; and uv sync $argv
end
