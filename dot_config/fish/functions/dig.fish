function dig --wraps=doggo
  if using doggo
    doggo $argv
  else
    command dig $argv
  end
end