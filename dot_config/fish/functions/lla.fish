function lla
  if using eza
    eza -la $argv
  else
    command ls -la $argv
  end
end
