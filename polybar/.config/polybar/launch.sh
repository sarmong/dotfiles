#!/bin/sh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

if type "xrandr"; then
  for m in $(xrandr --listactivemonitors | awk '{print $4}' | tail -n +2); do
    MONITOR=$m polybar --reload bar1 2>&1 | tee -a /tmp/polybar-"$m".log &
  done
else
  polybar --reload bar1 &
fi
