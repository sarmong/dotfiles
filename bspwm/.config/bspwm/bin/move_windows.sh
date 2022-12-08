#!/bin/sh

## This will move all windows from one monitor to another
## preserving desktop order

echo "moving windows"

from="$1"
to="$2"

desktops=$(bspc query -D -m "$from")

i=1
for desktop in $desktops; do
  nodes=$(bspc query -N -d "$desktop" -n .window)

  for node in $nodes; do
    bspc node "$node" --to-desktop "$to":^$i
  done

  i=$((i + 1))
done
