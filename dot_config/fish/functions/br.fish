function br

   if using brew

      switch $argv[1]
         case up; brew update; brew upgrade --greedy-auto-updates; brew cleanup; brew doctor
         case clean; brew bundle --file ~/config/Brewfile --cleanup --zap
         case in; brew bundle --file ~/config/Brewfile
         case '*'; brew $argv
      end

   end 

end