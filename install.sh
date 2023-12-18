#!/bin/sh

mkdir ~/docs
cd ~/docs

git clone https://github.com/sarmong/dotfiles.git
cd dotfiles
git submodule update --init

./bootstrap.sh
