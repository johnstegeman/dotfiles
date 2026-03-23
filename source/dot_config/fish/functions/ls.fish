function ls
  if using eza
    eza $argv
  else
    command ls $argv
  end
end
