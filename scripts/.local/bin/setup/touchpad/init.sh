#!/bin/sh

sudo mkdir /etc/X11/xorg.conf.d

sudo cp "$XDG_BIN_DIR"/setup/touchpad/99-overrides.conf /etc/X11/xorg.conf.d/
