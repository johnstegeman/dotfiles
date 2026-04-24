#!/usr/bin/env bash

# Keep laptop mode minimal because of the notch.
WORKSPACES=("1" "P")

# On laptop: items go on the right side (away from notch). On ultrawide: keep the cluster compact.
if [ "$LAPTOP_MODE" = false ]; then
    sketchybar --add item spacer.left left \
        --set spacer.left width=4 background.drawing=off label.drawing=off icon.drawing=off
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
        --set spacer.mid width=3 background.drawing=off label.drawing=off icon.drawing=off
fi
