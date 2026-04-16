#!/usr/bin/env bash

# AeroSpace workspaces. Each item subscribes to the aerospace_workspace_changed custom event
# fired by the persistent bridge in plugins/aerospace_bridge.sh.
WORKSPACES=("1" "P")

# On laptop: items go on the right side (away from notch). On ultrawide: left side with spacers.
if [ "$LAPTOP_MODE" = false ]; then
    sketchybar --add item spacer.left left \
        --set spacer.left width=10 background.drawing=off label.drawing=off icon.drawing=off
fi

for ws in "${WORKSPACES[@]}"; do
    sketchybar --add item "space.$ws" left \
        --set "space.$ws" \
        label.drawing=off \
        icon="$ws" \
        icon.padding_left=10 \
        icon.padding_right=10 \
        background.padding_left=-5 \
        background.padding_right=-5 \
        click_script="aerospace workspace $ws" \
        script="$PLUGIN_DIR/space.sh"
    sketchybar --subscribe "space.$ws" aerospace_workspace_changed
done

sketchybar --add bracket spaces '/space\..*/' \
    --set spaces \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$RED" \
    background.corner_radius="$CORNER_RADIUS" \
    background.color="$BAR_COLOR" \
    background.height=26 \
    background.drawing=on

if [ "$LAPTOP_MODE" = false ]; then
    sketchybar --add item spacer.mid left \
        --set spacer.mid width=5 background.drawing=off label.drawing=off icon.drawing=off
fi
