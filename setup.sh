#!/usr/bin/env bash

shopt -s dotglob

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

cd "$script_dir" || exit 1

linkto() {
  file="$1"
  to="$2"
  filename=$(basename "$file")
  dest="$to/$filename"
  target=$(readlink "$dest")

  # if directory and not link - ln will fail, so rename beforehand
  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    mv -v "$dest" "$dest~"
  fi

  # if dest already links to the same file, do nothing
  if [ ! "$target" = "$file" ]; then
    ln -sv --backup=numbered "$file" "$to"
  fi
}

linkdir() {
  from="$1"
  to="$2"
  for file in "$script_dir"/"$from"/*; do
    linkto "$file" "$to"
  done
}

mkdir -p ~/.config/
mkdir -p ~/.local

linkdir "home" "$HOME"
linkdir "dotconfig" "$HOME/.config"
linkto "$script_dir/dotlocal/bin" "$HOME/.local"

echo ""
echo "All files linked"
echo ""
echo "Now: "
echo "1: add git/git-work.conf same as git-personal.conf"
echo "2: add zsh/zsh-local and add necessary local configuration (e.g. default browser)"
echo "3: add newsboat password at newsboat/pw"
