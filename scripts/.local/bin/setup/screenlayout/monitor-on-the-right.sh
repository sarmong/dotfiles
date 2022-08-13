#!/bin/sh
connected=$(xrandr | grep " connected " | awk '{ print$1 }')
second_monitor=$(echo "$connected" | awk 'NR==2')

xrandr --output eDP-1 --mode 1920x1080 --pos 0x377 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 1920x0 --rotate normal
