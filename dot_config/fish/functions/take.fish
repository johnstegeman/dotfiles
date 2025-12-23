function take
  if test (count $argv) -eq 0
    echo "Error: take requires a directory name" >&2
    return 1
  end

  mkdir -p $argv[1]; and cd $argv[1]
end
