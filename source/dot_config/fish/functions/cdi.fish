function cdi --wraps=zi --description 'alias cdi=zi'
  if using zoxide
    zi $argv
  end
end
