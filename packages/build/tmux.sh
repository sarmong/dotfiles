#!/bin/sh

version="3.3a"

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p ~/.local/src/tmux
cd ~/.local/src/tmux || exit 1

wget "https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz"
aunpack "./tmux-$version.tar.gz"

cd "./tmux-$version" || exit 1

# fixes c-i and tab difference for neovim
git apply "$script_dir"/tmux-patch.diff

./configure && make

sudo make install
