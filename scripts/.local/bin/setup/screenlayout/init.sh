#!/bin/sh

if [ "$(cat /etc/hostname)" = "dell" ]; then
  "$XDG_BIN_DIR"/setup/screenlayout/monitor-on-the-left.sh
else
  "$XDG_BIN_DIR"/setup/screenlayout/monitor-on-the-right.sh
fi
