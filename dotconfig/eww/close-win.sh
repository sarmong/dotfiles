#!/bin/sh

window_id=$(cat /tmp/window_to_kill)
wmctrl -ic "$window_id"
echo "" >/tmp/window_to_kill

eww close prompt
