#!/usr/bin/env sh

setxkbmap "us,ru" -option caps:ctrl_modifier -option altwin:swap_alt_win -option altwin:alt_super_win
## Set Super to Alt
xmodmap -e "keycode 135 = Alt_R"

## Set to be Escape when tapped shortly with 1000ms timeout
killall xcape 2>/dev/null
xcape -t 1000 -e 'Caps_Lock=Escape'

## Start cursor movement after 250ms and at 45 lines per second
xset r rate 250 45

## ---------------------
## Old config

## This is now set by setxkbmap
# xkbcomp "$(dirname "$0")"/xkbconf.xkb "$DISPLAY"

## -------------------------
## For some guides see
# https://habr.com/ru/post/222285/
# https://wiki.archlinux.org/title/X_keyboard_extension
# https://unixforum.org/viewtopic.php?t=49203
