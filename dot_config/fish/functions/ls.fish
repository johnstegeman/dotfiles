function ls --wraps=eza
  if using eza
    eza $argv
  else
    command ls $argv
  end
end
