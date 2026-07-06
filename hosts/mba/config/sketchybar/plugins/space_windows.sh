#!/bin/bash
space_number=$1

windows=$(aerospace list-windows --workspace "$space_number" --json | jq -r '.[]["app-name"]')

icon_strip=""
if [ -n "$windows" ]; then
  while read -r app; do
    icon_strip+="$("$CONFIG_DIR/plugins/icon_map.sh" "$app") "
  done <<< "$windows"
fi

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

if [ "$space_number" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    icon.color=0xffffffff \
    label.color=0xffffffff \
    label="$icon_strip"
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color=0x70ffffff \
    label.color=0x50ffffff \
    label="$icon_strip"
fi
