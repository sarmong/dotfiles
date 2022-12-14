#!/usr/bin/env bash

shopt -s dotglob

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd "$script_dir" || exit 1

linkto() {
  file="$1"
  to="$2"
  filename=$(basename "$file")
  target=$(readlink "$to/$filename")

  if [ ! "$target" = "$file" ]; then
    ln -sv --backup=numbered "$file" "$to"
  fi
}

for file in "$script_dir"/home/*; do
  linkto "$file" "$HOME"
done

for file in "$script_dir"/dotconfig/*; do
  linkto "$file" "$HOME/.config"
done

mkdir -p ~/.local/

linkto "$script_dir/dotlocal/bin" "$HOME/.local"

echo "All files linked"
