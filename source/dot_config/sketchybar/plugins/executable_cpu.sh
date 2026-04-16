#!/usr/bin/env bash

NCPU=$(sysctl -n hw.ncpu)
sketchybar --set "$NAME" icon="" \
    label="$(ps -A -o %cpu | awk -v ncpu="$NCPU" '{s+=$1} END {s /= ncpu; printf "%.1f%%\n", s}')"
