#!/bin/sh

service_file="/etc/systemd/system/suspend.service"
script_file="/etc/systemd/system/suspend.sh"

[ -f "$service_file" ] || [ -L "$service_file" ] && sudo mv "$service_file" "$service_file"-old
[ -f "$script_file" ] || [ -L "$script_file" ] && sudo mv "$script_file" "$script_file"-old

sudo ln -s "$XDG_BIN_DIR"/services/suspend/suspend.service /etc/systemd/system
sudo ln -s "$XDG_BIN_DIR"/services/suspend/suspend.sh /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable suspend
