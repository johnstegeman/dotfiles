#!/usr/bin/env bash
# Persistent bridge: reads AeroSpace event stream, fires sketchybar custom events.
# Started by sketchybarrc on every reload (previous instance killed first).

/usr/local/bin/aerospace subscribe focused-workspace-changed focus-changed --no-send-initial 2>/dev/null | \
while IFS= read -r line; do
    EVENT=$(printf '%s' "$line" | sed 's/.*"_event":"\([^"]*\)".*/\1/')
    case "$EVENT" in
        focused-workspace-changed)
            WS=$(printf '%s' "$line" | sed 's/.*"workspace":"\([^"]*\)".*/\1/')
            [ -n "$WS" ] && sketchybar --trigger aerospace_workspace_changed workspace="$WS"
            ;;
        focus-changed)
            APP=$(printf '%s' "$line" | sed 's/.*"appName":"\([^"]*\)".*/\1/')
            ZONE=""
            echo "$line" | grep -q '"zoneName"' && \
                ZONE=$(printf '%s' "$line" | sed 's/.*"zoneName":"\([^"]*\)".*/\1/')
            sketchybar --trigger aerospace_focus_changed app_name="$APP" zone_name="$ZONE"
            ;;
    esac
done
