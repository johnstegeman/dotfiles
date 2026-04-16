#!/usr/bin/env bash

# Nerd Font volume icons via explicit UTF-8 bytes (portable across bash versions)
# nf-fa-volume_off (U+F026), nf-fa-volume_down (U+F027), nf-fa-volume_up (U+F028)
ICON_MUTED=$(printf '\xef\x80\xa6')
ICON_LOW=$(printf '\xef\x80\xa7')
ICON_HIGH=$(printf '\xef\x80\xa8')

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$MUTED" != "false" ]; then
    ICON="$ICON_MUTED"
    VOLUME=0
else
    case ${VOLUME} in
        100|[5-9]*)  ICON="$ICON_HIGH" ;;
        [1-4]*)      ICON="$ICON_LOW" ;;
        *)           ICON="$ICON_MUTED" ;;
    esac
fi

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
