#!/usr/bin/env sh

sudo rm /etc/keyd/default.conf

sudo ln -s ~/bin/services/keyd/default.conf /etc/keyd/

sudo service keyd restart
