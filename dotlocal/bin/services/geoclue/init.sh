#!/bin/sh

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

target_dir="$HOME/.config/systemd/user"

[ ! -d "$target_dir" ] && mkdir -p "$target_dir"

ln -s "$script_dir/geoclue-agent.service" "$target_dir"

systemctl --user enable --now geoclue-agent.service
