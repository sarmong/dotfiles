#!/bin/sh

connected=$(xrandr | grep " connected " | awk '{ print$1 }')
second_monitor=$(echo "$connected" | awk 'NR==2')

if [ "$second_monitor" ]; then
  "$XDG_BIN_DIR"/setup/screenlayout/monitor-on-the-right.sh "$second_monitor"
else
  "$XDG_BIN_DIR"/setup/screenlayout/undocked.sh
fi

feh --bg-fill "$XDG_PICTURES_DIR/wallpaper.png" &
