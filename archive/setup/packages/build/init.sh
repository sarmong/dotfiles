#!/bin/sh

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd "$script_dir" || exit 1

./tmux.sh
./newsboat.sh

nvvm use stable
