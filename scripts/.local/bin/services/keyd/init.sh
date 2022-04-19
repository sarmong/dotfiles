#!/usr/bin/env sh

dir="/etc/keyd"

file="$dir/default.conf"

[ ! -d "$dir" ] && sudo mkdir "$dir"

[ -f "$file" ] || [ -L "$file" ] && sudo mv "$file" "$file"-old

sudo ln -s "$XDG_BIN_DIR"/services/keyd/default.conf /etc/keyd/

sudo systemctl enable keyd
"$XDG_BIN_DIR"/services/keyd/restart-keyd
