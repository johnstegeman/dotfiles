#!/usr/bin/env bash

COLOR="$CYAN"

sketchybar --add item mic right \
    --set mic \
    update_freq=3 \
    icon.padding_left=10 \
    icon.padding_right=10 \
    icon.color="$COLOR" \
    label.drawing=off \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.padding_right=2 \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COLOR" \
    background.color="$BAR_COLOR" \
    background.drawing=on \
    click_script="$HOME/.config/sketchybar/helpers/mic_muted --toggle && sketchybar --update" \
    script="$PLUGIN_DIR/mic.sh"
