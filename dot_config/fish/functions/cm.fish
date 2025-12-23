function cm --description 'wrapper for chezmoi: ap or ed'
  if not using chezmoi
    echo "Error: chezmoi is not installed" >&2
    return 1
  end

  switch $argv[1]
    case ap
      chezmoi apply -v --no-pager -R=always
    case ed
      if using code
        code $(chezmoi source-path)
      else
        echo "Error: code command not found" >&2
        return 1
      end
    case cd
      cd $(chezmoi source-path)
    case '*'
      chezmoi $argv
  end
end