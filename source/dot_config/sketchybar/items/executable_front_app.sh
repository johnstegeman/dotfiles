#!/usr/bin/env bash

COLOR="$WHITE"

sketchybar \
    --add item front_app left \
    --set front_app \
    script="$PLUGIN_DIR/front_app.sh" \
    icon.drawing=off \
    background.height=26 \
    background.padding_left=0 \
    background.padding_right=10 \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COLOR" \
    background.corner_radius="$CORNER_RADIUS" \
    background.color="$BAR_COLOR" \
    background.drawing=on \
    label.color="$BACKGROUND" \
    label.padding_left=10 \
    label.padding_right=10 \
    associated_display=active \
    --subscribe front_app aerospace_focus_changed

# Set initial label immediately — the script only fires on events, not on load
FRONT_APP=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)
sketchybar --set front_app label="$FRONT_APP"
