#!/usr/bin/env bash

[ "$LAPTOP_MODE" = true ] && return  # no zones on laptop

sketchybar --add item zone left \
    --set zone \
    icon="–" \
    icon.color=0xff565f89 \
    icon.padding_left=10 \
    icon.padding_right=10 \
    icon.font="$FONT:Bold:13.0" \
    label.drawing=off \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.padding_left=0 \
    background.padding_right=0 \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COMMENT" \
    background.color="$BAR_COLOR" \
    background.drawing=on \
    script="$PLUGIN_DIR/zone.sh"
sketchybar --subscribe zone aerospace_focus_changed
