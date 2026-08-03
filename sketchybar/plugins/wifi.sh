#!/usr/bin/env bash

CACHE_FILE="/tmp/sketchybar_wifi_ssid"
WIFI_INT=$(networksetup -listallhardwareports 2>/dev/null | awk '/Hardware Port: (Wi-Fi|AirPort)/{getline; print $2}')
[ -z "$WIFI_INT" ] && WIFI_INT="en0"

STATUS=$(ifconfig "$WIFI_INT" 2>/dev/null | grep "status:" | awk '{print $2}')

if [ "$STATUS" != "active" ]; then
  rm -f "$CACHE_FILE"
  sketchybar --set "$NAME" label="WIFI Off"
  exit 0
fi

SSID=$(ipconfig getsummary "$WIFI_INT" 2>/dev/null | grep " SSID :" | awk -F ' : ' '{print $2}')

if [ "$SSID" = "<redacted>" ] || [ -z "$SSID" ]; then
  if [ -s "$CACHE_FILE" ]; then
    SSID=$(cat "$CACHE_FILE" | head -n 1)
  else
    SSID="Connected"
    (
      FETCHED=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Current Network Information:/{getline; print $1}' | head -n 1 | tr -d ':')
      if [ -n "$FETCHED" ] && [ "$FETCHED" != "Network" ]; then
        echo "$FETCHED" > "$CACHE_FILE"
        sketchybar --set "$NAME" label="WIFI ${FETCHED}"
      fi
    ) &
  fi
else
  echo "$SSID" > "$CACHE_FILE"
fi

sketchybar --set "$NAME" label="WIFI ${SSID}"
