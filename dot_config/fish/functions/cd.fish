function cd --wraps=z --description 'alias cd=z'
  if using zoxide
    z $argv
  else
    builtin cd $argv
  end
end