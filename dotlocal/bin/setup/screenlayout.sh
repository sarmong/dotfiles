#!/bin/sh

monitor_position="${1:-"right"}"

connected=$(xrandr | grep " connected " | awk '{ print$1 }')
second_monitor=$(echo "$connected" | awk 'NR==2')
laptop_resolution=$([ "$(hostname)" = "sich" ] && echo "1920x1200" || echo "1920x1080")

if [ "$second_monitor" ]; then
  if [ "$monitor_position" = "right" ]; then
    xrandr --output eDP-1 --mode "$laptop_resolution" --pos 0x377 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 1920x0 --rotate normal
  elif [ "$monitor_position" = "left" ]; then
    xrandr --output eDP-1 --mode "$laptop_resolution" --pos 1920x470 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 0x0 --rotate normal
  fi
else
  xrandr --output eDP-1 --primary --mode "$laptop_resolution" --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --off --output DP-2-2 --off --output DP-2-3 --off
fi

set-wp
