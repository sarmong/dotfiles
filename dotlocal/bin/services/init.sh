#!/bin/sh

sudo systemctl enable --now ufw

ufw default deny
ufw allow from 192.168.0.0/24
ufw allow qbittorrent
ufw limit ssh
ufw enable
