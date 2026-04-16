#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

case "$zone_name" in
    left)   LABEL="L"; COLOR="$BLUE"   ;;
    center) LABEL="C"; COLOR="$GREEN"  ;;
    right)  LABEL="R"; COLOR="$ORANGE" ;;
    *)      LABEL="–"; COLOR=0xff565f89 ;;
esac

sketchybar --set "$NAME" \
    icon="$LABEL" \
    icon.color="$COLOR" \
    background.border_color="$COLOR"
