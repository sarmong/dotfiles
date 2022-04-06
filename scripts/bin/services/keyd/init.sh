#!/usr/bin/env sh

[ -f /etc/keyd/default.conf ] && sudo rm /etc/keyd/default.conf

sudo ln -s ~/bin/services/keyd/default.conf /etc/keyd/

sudo systemctl enable keyd
~/bin/services/keyd/restart-keyd
