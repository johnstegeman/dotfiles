function ll --wraps='eza -l'
  if using eza
    eza -l $argv
  else
    command ls -l $argv
  end
end
