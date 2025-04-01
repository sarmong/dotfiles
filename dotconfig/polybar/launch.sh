#!/bin/sh

polybar-msg cmd quit

PATH="$PATH:$XDG_CONFIG_HOME/polybar/bin"

monitors=$(xrandr --listactivemonitors | tail -n +2 | awk '{print $4}')

i=0
for m in $monitors; do
  bar=$([ $i = 0 ] && echo "primary" || echo "secondary")
  i=$((i + 1))
  echo "$bar - $m"

  MONITOR=$m polybar --reload "$bar" 2>&1 | tee -a /tmp/polybar-"$m".log &
done
