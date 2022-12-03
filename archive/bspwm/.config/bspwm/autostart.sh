#!/bin/sh

killall sxhkd
killall polybar
killall picom

sxhkd &
"$XDG_CONFIG_HOME/polybar/launch.sh" &
picom &

## Configurations
feh --bg-fill "$XDG_PICTURES_DIR/wallpaper.png" &
"$XDG_BIN_DIR/setup/screenlayout/init.sh" &
"$XDG_BIN_DIR/setup/keyboard/init.sh" &

# run only on initial start
if [ "$1" = 0 ]; then
  inputplug -c "$XDG_BIN_DIR/setup/keyboard/on-connect.sh" &
  unclutter &
  xsetroot -cursor_name left_ptr & # remove x-shaped cursor when no windows open
  # bluetooth on &

  ## Essentials
  deadd-notification-center &
  lxpolkit &
  nm-applet &         # indicator # network tray
  volctl &            # audiocontrol tray
  xfce4-power-manager & # power manager tray
  conky &
  udiskie --smart-tray # mounts drives automatically

  ## Applications
  nextcloud &
  libinput-gestures-setup restart &
  CM_SELECTIONS='clipboard' clipmenud &
  redshift &
  # safeeyes
  aw-qt &
fi
