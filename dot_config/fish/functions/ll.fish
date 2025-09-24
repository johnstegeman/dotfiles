function ll --wraps='eza -l'
  if using eza
    eza -l $argv
  else 
    ls -l $argv
  end
        
end
