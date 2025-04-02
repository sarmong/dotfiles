#!/bin/sh

OUTPUTS=$(i3-msg -t get_outputs | jq -r '.[] | select(.active == true) .name')
CURRENT_OUTPUT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).output')

NEXT_OUTPUT=""
FOUND_CURRENT=0

for output in $OUTPUTS; do
    if [ "$FOUND_CURRENT" -eq 1 ]; then
        NEXT_OUTPUT="$output"
        break
    fi
    if [ "$output" = "$CURRENT_OUTPUT" ]; then
        FOUND_CURRENT=1
    fi
done

if [ -z "$NEXT_OUTPUT" ]; then
    NEXT_OUTPUT=$(echo "$OUTPUTS" | head -n 1)
fi

i3-msg focus output "$NEXT_OUTPUT"
