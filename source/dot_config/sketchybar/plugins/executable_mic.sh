#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

# nf-fa-microphone U+F130 = \xef\x84\xb0
# nf-fa-microphone-slash U+F131 = \xef\x84\xb1
ICON_ON=$(printf '\xef\x84\xb0')
ICON_OFF=$(printf '\xef\x84\xb1')

MUTED=$("$HOME/.config/sketchybar/helpers/mic_muted" 2>/dev/null)

if [ "$MUTED" = "true" ]; then
    ICON="$ICON_OFF"
    COLOR="$RED"
else
    ICON="$ICON_ON"
    COLOR="$GREEN"
fi

sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color="$COLOR" \
    background.border_color="$COLOR"
