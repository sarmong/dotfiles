#!/usr/bin/env sh

sudo ln -s ~/bin/services/keyd/default.conf /etc/keyd/

sudo systemd restart keyd
