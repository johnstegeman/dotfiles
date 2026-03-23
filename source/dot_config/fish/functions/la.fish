function la
  if using eza
    eza -a $argv
  else
    command ls -a $argv
  end
end
