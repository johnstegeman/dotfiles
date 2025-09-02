function cmcd --wraps='cd $(chezmoi source-path)' --description 'alias cmcd cd $(chezmoi source-path)'
  cd $(chezmoi source-path) $argv
        
end
