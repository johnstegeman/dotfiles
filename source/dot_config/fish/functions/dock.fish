function dock
  if not using haven
    echo "Error: haven is not installed" >&2
    return 1
  end

  switch $argv[1]
    case backup
      set -l dock_plist ~/Library/Preferences/com.apple.dock.plist
      set -l backup_path $(haven source-path)/source/config/dock.backup
      if test -f $dock_plist
        echo "backing up dock"
        cp -f $dock_plist $backup_path
      else
        echo "Error: Dock plist not found at $dock_plist" >&2
        return 1
      end
    case restore
      set -l backup_path $(haven source-path)/source/config/dock.backup
      if test -f $backup_path
        echo "restoring dock"
        cp $backup_path ~/Library/Preferences/com.apple.dock.plist
        killall -9 Dock
      else
        echo "Error: Dock backup not found at $backup_path" >&2
        return 1
      end
    case '*'
      echo "Usage: dock [backup|restore]" >&2
      return 1
  end
end