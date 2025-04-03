#!/bin/sh

type="$1"

if [ "$type" = "term" ]; then
  tdrop -n term -ma -w 50% -h 440 -x 25% -y 35 --pre-map-hook 'tdrop hide_all' "$TERMINAL" --class dropdown-term
elif [ "$type" = "scratch" ]; then
  tdrop -n scratch -ma -w 50% -h 440 -x 25% -y 35 --pre-map-hook 'tdrop hide_all' "$TERMINAL" \
    --class dropdown-term --working-directory ~/docs/nc \
    -e "$SHELL" -c "nvim -c \"autocmd TextChanged,InsertLeave <buffer> silent write\" scratch.txt ; $SHELL"
fi
