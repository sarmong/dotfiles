#!/usr/bin/env sh

dir="/etc/keyd"

file="$dir/default.conf"

[ ! -d "$dir" ] && sudo mkdir "$dir"

[ -f "$file" ] || [ -L "$file" ] && sudo mv "$file" "$file"-old

if [ "$(cat /etc/hostname)" = 'air' ]; then
  file="mac.conf"
else
  file="default.conf"
fi

sudo ln -s "$XDG_BIN_DIR"/services/keyd/"$file" /etc/keyd/default.conf

sudo systemctl enable keyd
"$XDG_BIN_DIR"/services/keyd/restart-keyd
