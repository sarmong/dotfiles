#!/bin/sh

run() {
  pgrep -u "$USER" -f "$(basename "$1")" >/dev/null || setsid "$@" >/dev/null 2>&1 &
}

## Essentials
run dunst
run lxpolkit
run nm-applet --indicator # network tray
run picom --daemon

if ! pidof sxhkd; then
  wm=$(wmctrl -m | head -1 | awk -F": " '{print $2}')

  if [ "$wm" = "bspwm" ]; then
    cat "$XDG_CONFIG_HOME/sxhkd/sxhkdrc" "$XDG_CONFIG_HOME/sxhkd/sxhkdrc-bspwm" | sxhkd -c /dev/stdin &
  else
    sxhkd &
  fi
fi

## Configurations
run "$XDG_BIN_DIR"/setup/screenlayout.sh
run "$XDG_BIN_DIR"/setup/keyboard/init.sh
run inputplug -c "$XDG_BIN_DIR/setup/keyboard/on-connect.sh"
run libinput-gestures-setup restart
run playerctld daemon
run set-wp
run unclutter

## Applications
run clipmenud
run conky
run flameshot
run redshift
run safeeyes
run udiskie --smart-tray
run volctl
run xfce4-power-manager
run blueman-applet
