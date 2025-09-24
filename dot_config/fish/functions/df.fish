function df --wraps=duf
  if using duf
    duf $argv
  else
    df $argv
  end     
end
