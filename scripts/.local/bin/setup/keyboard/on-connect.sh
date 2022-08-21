#!/usr/bin/env sh

event=$1
id=$2
type=$3

if [ "$event" = "XIDeviceEnabled" ] && [ "$type" = "XISlaveKeyboard" ]; then

  # setxkbmap "us,ru"
  xkbcomp ~/.config/xkb/config "$DISPLAY"

  ## Start cursor movement after 250ms and at 45 lines per second
  xset r rate 250 45
fi
