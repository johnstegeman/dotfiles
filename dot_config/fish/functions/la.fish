function la --wraps='eza -a'
  if using eza
    eza -a $argv
  else
    command ls -a $argv
  end
end
