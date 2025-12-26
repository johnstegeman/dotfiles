function lla
  if using lsd
    lsd -la $argv
  else
    command ls -la $argv
  end
end
