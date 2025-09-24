function lla --wraps='eza -la'
  if using eza
    eza -la $argv
  else 
    ls -la $argv
  end
        
end
