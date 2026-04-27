#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

# Derive workspace name from item name (space.1 → "1", space.P → "P")
WORKSPACE="${NAME#space.}"

# Use focused workspace from the AeroSpace bridge event payload.
FOCUSED="$workspace"

if [ "$FOCUSED" = "$WORKSPACE" ]; then
    sketchybar --animate tanh 5 --set "$NAME" icon.color="$RED"
else
    sketchybar --animate tanh 5 --set "$NAME" icon.color="$COMMENT"
fi
