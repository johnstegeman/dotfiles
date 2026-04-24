#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

PRESET="$preset_name"
LABEL="default"
COLOR="$COMMENT"

if [ -n "$PRESET" ]; then
    LABEL="$PRESET"
    COLOR="$WHITE"
fi

if [ "$PRESET" = "presentation" ]; then
    LABEL="presentation"
    COLOR="$RED"
fi

sketchybar --set "$NAME" \
    label="$LABEL" \
    icon.color="$COLOR" \
    label.color="$BACKGROUND" \
    background.color="$BAR_COLOR" \
    background.border_color="$COLOR"
