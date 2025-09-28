function cd --wraps=z --description 'alias cd=z'
    if using z
      z $argv
   else
      cd $argv
   end
end