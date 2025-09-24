function rm --wraps=trash 
  if using trash
    trash $argv
  else 
    rm $argv
  end
end
