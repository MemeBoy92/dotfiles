#!/usr/bin/env bash

if [ "$INFO" != "" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)')"
fi

MUTED="$(osascript -e 'output muted of (get volume settings)')"

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ] 2>/dev/null; then
  sketchybar --set "$NAME" label="VOL Muted"
else
  sketchybar --set "$NAME" label="VOL ${VOLUME}%"
fi
