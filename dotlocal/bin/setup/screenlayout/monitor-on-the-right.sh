#!/bin/sh
second_monitor="$1"

xrandr --output eDP-1 --mode 1920x1080 --pos 0x377 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 1920x0 --rotate normal
