function la --wraps='eza -a'
  if using eza
    eza -a $argv
  else 
    ls -a $argv
  end
        
end
