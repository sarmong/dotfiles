#!/bin/sh
second_monitor="$1"

xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 368x0 --rotate normal
