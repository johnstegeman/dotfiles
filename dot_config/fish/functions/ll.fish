function ll
  if using lsd
    lsd -l $argv
  else
    command ls -l $argv
  end
end
