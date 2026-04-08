function du --wraps='dua i'
  if using dua
    dua i $argv
  else
    command du $argv
  end
end
