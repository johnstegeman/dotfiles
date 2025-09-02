function cmedit --wraps='code $(chezmoi source-path)' --description 'alias cmedit code $(chezmoi source-path)'
  code $(chezmoi source-path) $argv
        
end
