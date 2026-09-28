function cd --wraps=ze --description 'alias cd=ze'
  if using ze
    ze $argv
  else
    builtin cd $argv
  end
end
