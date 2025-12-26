function la
  if using lsd
    lsd -a $argv
  else
    command ls -a $argv
  end
end
