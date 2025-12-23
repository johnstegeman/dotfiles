function br
  if not using brew
    echo "Error: brew is not installed" >&2
    return 1
  end

  switch $argv[1]
    case up
      brew update; brew upgrade --greedy-auto-updates; brew cleanup; brew doctor
    case clean
      if test -f ~/config/Brewfile
        brew bundle --file ~/config/Brewfile --cleanup --zap
      else
        echo "Error: Brewfile not found at ~/config/Brewfile" >&2
        return 1
      end
    case in
      if test -f ~/config/Brewfile
        brew bundle --file ~/config/Brewfile
      else
        echo "Error: Brewfile not found at ~/config/Brewfile" >&2
        return 1
      end
    case '*'
      brew $argv
  end
end