# shellcheck shell=sh

env_file="$HOME/.config/zsh/zsh-exports"
[ -f "$env_file" ] && . "$env_file"
