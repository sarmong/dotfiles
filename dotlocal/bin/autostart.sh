#!/bin/sh

run() {
  pgrep -u "$USER" -f "$(basename "$1")" >/dev/null || setsid "$@" >/dev/null 2>&1 &
}

wm=$(wmctrl -m | head -1 | awk -F": " '{print $2}')

## Essentials
run xsettingsd
run dunst
run lxpolkit
run nm-applet --indicator # network tray
run picom --daemon

if ! pidof sxhkd; then
  if [ "$wm" = "bspwm" ]; then
    cat "$XDG_CONFIG_HOME/sxhkd/sxhkdrc" "$XDG_CONFIG_HOME/sxhkd/sxhkdrc-bspwm" | sxhkd -c /dev/stdin &
  else
    sxhkd &
  fi
fi

if [ "$wm" = "i3" ]; then
  run "$XDG_CONFIG_HOME"/i3/bin/keyboard_layout_watcher.py
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
run redshift -t 6500:2500
run safeeyes
run udiskie --smart-tray
run volctl
GTK_THEME=Adwaita:dark run xfce4-power-manager
run blueman-applet
