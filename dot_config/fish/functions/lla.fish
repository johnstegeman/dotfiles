function lla --wraps='eza -la'
  if using eza
    eza -la $argv
  else
    command ls -la $argv
  end
end
