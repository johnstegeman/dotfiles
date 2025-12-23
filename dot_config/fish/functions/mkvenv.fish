function mkvenv
  if not using uv
    echo "Error: uv is not installed" >&2
    return 1
  end

  if test (count $argv) -gt 0
    uv venv --python $argv[1]
  else
    uv venv
  end
end
