#!/bin/bash

# Toggle Ghostty Quick Terminal overlay cleanly
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! ps aux | grep -i "[g]hostty" >/dev/null 2>&1; then
    # Ghostty is closed -> launch app and wait for startup
    open -ga Ghostty
    for i in {1..20}; do
        if ps aux | grep -i "[g]hostty" >/dev/null 2>&1; then
            break
        fi
        sleep 0.05
    done
    sleep 0.15
fi

# Send single native toggle key event
"$SCRIPT_DIR/ghostty-toggle-key"
