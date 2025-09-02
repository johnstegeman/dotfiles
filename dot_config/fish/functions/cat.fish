function cat --wraps=bat
  if using bat
    bat $argv
  else 
    cat $argv
  end  
end
