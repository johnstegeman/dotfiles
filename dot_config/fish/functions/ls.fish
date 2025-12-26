function ls
  if using lsd
    lsd $argv
  else
    command ls $argv
  end
end
