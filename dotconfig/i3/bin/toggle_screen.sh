#!/bin/sh

# Get the list of connected outputs using i3-msg and jq
OUTPUTS=$(i3-msg -t get_outputs | jq -r '.[] | select(.active == true) .name')

# Get the currently focused output
CURRENT_OUTPUT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).output')

# Initialize variables
NEXT_OUTPUT=""
FOUND_CURRENT=0

# Loop through the outputs to find the next one
for output in $OUTPUTS; do
    if [ "$FOUND_CURRENT" -eq 1 ]; then
        NEXT_OUTPUT="$output"
        break
    fi
    if [ "$output" = "$CURRENT_OUTPUT" ]; then
        FOUND_CURRENT=1
    fi
done

# If no next output was found, wrap around to the first output
if [ -z "$NEXT_OUTPUT" ]; then
    NEXT_OUTPUT=$(echo "$OUTPUTS" | head -n 1)
fi

# Focus the next output
i3-msg focus output "$NEXT_OUTPUT"
