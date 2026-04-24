#!/usr/bin/env bash
# Optional bridge for zone-preset-changed events. Safe on older AeroSpace builds: if the
# event is unsupported, the subscribe command exits and the preset badge simply stays static.

/usr/local/bin/aerospace subscribe zone-preset-changed 2>/dev/null | \
while IFS= read -r line; do
    PRESET=""
    WORKSPACE=""

    if ! echo "$line" | grep -q '"presetName":null'; then
        PRESET=$(printf '%s' "$line" | sed -n 's/.*"presetName":"\([^"]*\)".*/\1/p')
    fi

    WORKSPACE=$(printf '%s' "$line" | sed -n 's/.*"workspace":"\([^"]*\)".*/\1/p')
    sketchybar --trigger aerospace_preset_changed workspace="$WORKSPACE" preset_name="$PRESET"
done
