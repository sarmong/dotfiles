#!/bin/sh

pidof sxhkd && kill -s USR1 "$(pidof sxhkd)" || sxhkd &

"$XDG_BIN_DIR/setup/screenlayout/init.sh" &

# run only on initial start
if [ "$1" = 0 ]; then
  picom --daemon
  "$XDG_CONFIG_HOME/polybar/launch.sh" &

  ## Configurations
  "$XDG_BIN_DIR/setup/keyboard/init.sh" &
  inputplug -c "$XDG_BIN_DIR/setup/keyboard/on-connect.sh" &
  unclutter &
  # xsetroot -cursor_name left_ptr & # remove x-shaped cursor when no windows open
  # bluetooth on &

  ## Essentials
  deadd-notification-center &
  lxpolkit &
  nm-applet &           # indicator # network tray
  xfce4-power-manager & # power manager tray
  conky &
  udiskie --smart-tray & # mounts drives automatically

  ## Applications
  nextcloud &
  # libinput-gestures-setup restart &
  CM_SELECTIONS='clipboard' clipmenud &
  redshift &
  # safeeyes

  sleep 5
  volctl & # audiocontrol tray
  aw-qt &
fi
