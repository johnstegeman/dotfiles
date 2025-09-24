function du --wraps='dua i'
  if using dua
    dua i $argv
  else 
    du $argv
  end
end
