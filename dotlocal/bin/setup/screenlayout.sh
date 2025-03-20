#!/bin/sh

connected=$(xrandr | grep " connected " | awk '{ print$1 }')
second_monitor=$(echo "$connected" | awk 'NR==2')
laptop_resolution=$([ "$(hostname)" = "sich" ] && echo "1920x1200" || echo "1920x1080")

single_screen() {
  xrandr --output eDP-1 --primary --mode "$laptop_resolution" --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --off --output DP-2-2 --off --output DP-2-3 --off
}

second_screen() {
  xrandr --output "$second_monitor" --primary --mode 1920x1080 --right-of eDP-1 --pos 1920x0 --rotate normal
}

if [ "$1" = "-s" ]; then
  single_screen
elif [ "$second_monitor" ]; then
  second_screen
else
  single_screen
fi

set-wp
