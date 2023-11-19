#!/bin/sh

sudo systemctl enable --now ufw

sudo ufw default deny
sudo ufw allow from 192.168.0.0/24
sudo ufw allow qbittorrent
sudo ufw allow syncthing
sudo ufw limit ssh
sudo ufw enable
