function cat --wraps=bat
  if using bat
    bat $argv
  else
    command cat $argv
  end
end
