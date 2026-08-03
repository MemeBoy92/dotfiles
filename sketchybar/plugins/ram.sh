#!/usr/bin/env bash

TOTAL_BYTES=$(sysctl -n hw.memsize)
PAGE_SIZE=$(vm_stat | grep "page size of" | awk '{print $8}')
PAGES_FREE=$(vm_stat | grep "Pages free:" | awk '{print $3}' | tr -d '.')
PAGES_INACTIVE=$(vm_stat | grep "Pages inactive:" | awk '{print $3}' | tr -d '.')
PAGES_SPECULATIVE=$(vm_stat | grep "Pages speculative:" | awk '{print $3}' | tr -d '.')

FREE_PAGES=$((PAGES_FREE + PAGES_INACTIVE + PAGES_SPECULATIVE))
FREE_BYTES=$((FREE_PAGES * PAGE_SIZE))

USED_BYTES=$((TOTAL_BYTES - FREE_BYTES))
PERCENT=$(echo "scale=0; ($USED_BYTES * 100) / $TOTAL_BYTES" | bc 2>/dev/null || echo "0")

sketchybar --set "$NAME" label="RAM ${PERCENT}%"
