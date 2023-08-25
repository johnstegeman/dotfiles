#!/bin/bash

defaults delete com.apple.dock persistent-apps

dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /System/Applications/Launchpad.app)" \
    '{"tile-type"="small-spacer-tile";}' \
    "$(dock_item /Applications/Arc.app)" \
    "$(dock_item /Applications/Email.app)" \
    '{"tile-type"="small-spacer-tile";}' \
    "$(dock_item /Applications/Cron.app)" \
    "$(dock_item /Applications/Asana.app)" \
    "$(dock_item /Applications/Notability.app)" \
    '{"tile-type"="small-spacer-tile";}' \
    "$(dock_item /Applications/iTerm.app)" \
    "$(dock_item /Applications/Slack.app)" \
    "$(dock_item /System/Applications/Messages.app)" \
    '{"tile-type"="small-spacer-tile";}' \
    "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(dock_item /Applications/Neo4j\ Desktop.app)" \
    '{"tile-type"="small-spacer-tile";}' \
    "$(dock_item /System/Applications/System\ Settings.app)"

defaults delete com.apple.dock recent-apps

killall Dock