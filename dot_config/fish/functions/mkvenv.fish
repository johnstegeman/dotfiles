function mkvenv
    if test (count $argv) -gt 0
        uv venv --python $argv[1]
    else
        uv venv
    end
end
