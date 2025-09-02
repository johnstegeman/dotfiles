function uvu --wraps='uv lock --upgrade; uv sync' --description 'alias uvu uv lock --upgrade; uv sync'
  if using uv
    uv lock --upgrade; uv sync $argv
  end
        
end
