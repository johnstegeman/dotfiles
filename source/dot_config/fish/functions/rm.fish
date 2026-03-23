function rm --wraps=trash
  if using trash
    trash $argv
  else
    command rm $argv
  end
end
