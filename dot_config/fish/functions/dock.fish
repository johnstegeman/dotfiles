function dock

   switch $argv[1]

      case backup
         echo "backing up dock"
         cp  ~/Library/Preferences/com.apple.dock.plist  $(chezmoi source-path)/config/dock.backup

      case restore
         echo "restoring dock"
         cp $(chezmoi source-path)/config/dock.backup ~/Library/Preferences/com.apple.dock.plist
         killall -9 Dock

   end

end