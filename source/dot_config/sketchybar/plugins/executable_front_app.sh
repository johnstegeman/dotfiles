#!/usr/bin/env sh

case "$SENDER" in
"aerospace_focus_changed")
    sketchybar --set "$NAME" label="$app_name"
    ;;
*)
    # Initial load — query the current frontmost app directly
    FRONT_APP=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)
    sketchybar --set "$NAME" label="$FRONT_APP"
    ;;
esac
