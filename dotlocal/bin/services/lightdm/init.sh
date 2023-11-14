#!/usr/bin/env sh

conf_file="/etc/lightdm/lightdm.conf"
greeter_conf="/etc/lightdm/slick-greeter.conf"

[ -f "$conf_file" ] || [ -L "$conf_file" ] && sudo mv "$conf_file" "$conf_file-old"
[ -f "$greeter_conf" ] || [ -L "$greeter_conf" ] && sudo mv "$greeter_conf" "$greeter_conf-old"

sudo ln -s "$XDG_BIN_DIR"/services/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
sudo ln -s "$XDG_BIN_DIR"/services/lightdm/slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo ln -s "$XDG_BIN_DIR"/services/lightdm/wp.jpg /etc/lightdm/wp.jpg
sudo ln -s "$XDG_BIN_DIR"/services/lightdm/Xsession /etc/lightdm/Xsession

sudo systemctl enable lightdm
