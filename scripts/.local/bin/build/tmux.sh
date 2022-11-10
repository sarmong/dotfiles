#!/bin/sh

version="3.3a"

mkdir -p ~/.local/src/tmux
cd ~/.local/src/tmux

wget "https://gist.githubusercontent.com/sarmong/1706311fcce3db976f7862d8a7039641/raw/2c900477a5ef01b9266d471167bbbc76ab1f8752/tmux-patch.diff"
wget "https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz"

aunpack "./tmux-$version.tar.gz"

cd "./tmux-$version"

git apply ../tmux-patch.diff

./configure && make

sudo make install
