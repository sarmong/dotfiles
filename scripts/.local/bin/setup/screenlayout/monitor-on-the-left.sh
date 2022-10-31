#!/bin/sh

second_monitor="$1"

xrandr --output eDP-1 --mode 1920x1080 --pos 1920x470 --rotate normal --output "$second_monitor" --primary --mode 1920x1080 --pos 0x0 --rotate normal
