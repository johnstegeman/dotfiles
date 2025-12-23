function df --wraps=duf
  if using duf
    duf $argv
  else
    command df $argv
  end
end
