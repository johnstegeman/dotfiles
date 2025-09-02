function br

   if using brew

      switch $argv[1]
         case up; brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor
         case clean; brew bundle --file ~/config/Brewfile --cleanup --zap
      end

   end 

end