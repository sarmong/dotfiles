#!/bin/sh

sudo ln -s "$XDG_BIN_DIR"/services/suspend/suspend.service /etc/systemd/system
sudo ln -s "$XDG_BIN_DIR"/services/suspend/suspend.sh /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable suspend
