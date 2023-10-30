#!/bin/sh

full_path="$PWD/$1"
if [ -z "$TMUX" ]; then
  nvim "$full_path"
else
  window_name="neovim"

  nvim_pid=$(tmux list-panes -t $window_name -F "#{pane_pid}" | xargs pgrep --parent | xargs pgrep --parent)

  socket="/run/user/1000/nvim.$nvim_pid.0"

  nvim --server "$socket" --remote-tab "$full_path"

  tmux select-window -t "$window_name"
fi
