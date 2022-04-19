#!/bin/sh

dir="/etc/X11/xorg.conf.d"

[ ! -d "$dir" ] && sudo mkdir "$dir"

sudo cp "$XDG_BIN_DIR"/setup/touchpad/99-overrides.conf /etc/X11/xorg.conf.d/
