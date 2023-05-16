#!/bin/sh

version="r2.29"

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p ~/.local/src/newsboat
cd ~/.local/src/newsboat || exit 1

curl --remote-name --location "https://github.com/newsboat/newsboat/archive/refs/tags/$version.tar.gz"
aunpack "./$version.tar.gz"

cd "./newsboat-$version" || exit 1

# don't move cursor down on toggle read
git apply "$script_dir"/newsboat.diff

make

sudo make install
