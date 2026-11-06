#!/usr/bin/env bash

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
count=$(aerospace list-windows --workspace "$1" --count)

if [ "$1" = "$FOCUSED" ]; then
    sketchybar --set "$NAME" drawing=on background.drawing=on
elif [ "$count" -gt 0 ]; then
    sketchybar --set "$NAME" drawing=on background.drawing=off
else
    sketchybar --set "$NAME" drawing=off
fi
