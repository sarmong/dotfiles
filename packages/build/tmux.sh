#!/bin/sh

sudo apt install -y libevent-dev bison byacc
sudo apt-mark auto libevent-dev bison byacc # mark as dependency (like pacman -S --asdeps)

# see https://github.com/tmux/tmux/issues/2705
version="3.3a"

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p ~/.local/src/tmux
cd ~/.local/src/tmux || exit 1

# curl --remote-name --location "https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz"
# aunpack "./tmux-$version.tar.gz"
git clone --depth=1 https://github.com/tmux/tmux.git
cd tmux || exit 1
sh autogen.sh

# cd "./tmux-$version" || exit 1

# fixes c-i and tab difference for neovim
git apply "$script_dir"/tmux-patch.diff

./configure && make

sudo make install
