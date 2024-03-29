#!/usr/bin/env bash

mkdir ~/docs
cd ~/docs

git clone https://github.com/sarmong/dotfiles.git
cd dotfiles
git submodule update --init --recursive

read -p "Press 1 or Enter to bootstrap server or 2 to bootstrap desktop" bootstrap

if [ "$bootstrap" = "2" ]; then
  ./bootstrap.sh
else
  ./bootstrap-server.sh
fi
