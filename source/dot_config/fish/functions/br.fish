function br
  if not using brew
    echo "Error: brew is not installed" >&2
    return 1
  end

  switch $argv[1]
    case up
      brew update; brew upgrade; brew cleanup; brew doctor
    case in
      # Packages are tracked per module (modules/*.toml -> brew/Brewfile.*), so haven is the
      # only thing that knows the whole set. There is no central ~/config/Brewfile.
      if using haven
        haven apply
      else
        echo "Error: haven is not installed" >&2
        return 1
      end
    case '*'
      brew $argv
  end
end
