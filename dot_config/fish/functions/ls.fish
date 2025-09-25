function ls --wraps=eza
  if using eza
    eza $argv
  else
    /bin/ls $argv
  end
        
end
