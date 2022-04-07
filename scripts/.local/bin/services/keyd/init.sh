#!/usr/bin/env sh

[ -f /etc/keyd/default.conf ] && sudo rm /etc/keyd/default.conf

sudo ln -s "$XDG_BIN_DIR"/services/keyd/default.conf /etc/keyd/

sudo systemctl enable keyd
"$XDG_BIN_DIR"/services/keyd/restart-keyd
