#!/usr/bin/env sh

# setxkbmap "us,ru"
xkbcomp ~/.config/xkb/config "$DISPLAY"

## Start cursor movement after 250ms and at 45 lines per second
xset r rate 250 45
