#!/usr/bin/env bash

[ "$LAPTOP_MODE" = true ] && return

sketchybar --add item preset left \
    --set preset \
    icon="Layout" \
    icon.color="$COMMENT" \
    icon.padding_left=8 \
    icon.padding_right=4 \
    icon.font="$FONT:Bold:12.0" \
    label="default" \
    label.color="$BACKGROUND" \
    label.padding_right=8 \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.padding_left=0 \
    background.padding_right=0 \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COMMENT" \
    background.color="$BAR_COLOR" \
    background.drawing=on \
    click_script="aerospace overview-zones" \
    script="$PLUGIN_DIR/preset.sh"
sketchybar --subscribe preset aerospace_preset_changed
