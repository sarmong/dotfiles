#!/usr/bin/env sh

[ -f "/etc/lightdm/lightdm.conf" ] && sudo mv "/etc/lightdm/lightdm.conf" "/etc/lightdm/lightdm-old.conf"
[ -f "/etc/lightdm/slick-greeter.conf" ] && sudo mv "/etc/lightdm/slick-greeter.conf" "/etc/lightdm/slick-greeter-old.conf"

sudo ln -s "$XDG_BIN_DIR"/services/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
sudo ln -s "$XDG_BIN_DIR"/services/lightdm/slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo ln -s "$XDG_BIN_DIR"/services/lightdm/wp.jpg /etc/lightdm/wp.jpg

sudo systemctl enable lightdm
