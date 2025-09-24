function ls --wraps=eza
  if using eza
    eza $argv
  else
    ls $argv
  end
        
end
