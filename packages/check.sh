#!/usr/bin/env bash

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir" || exit 1

to_install=$(sed 's/#.*$//g' "./arch.txt" | sed '/^$/d' | sort | awk '{ print $1 }')
installed=$(pacman -Qqe)

## installed but not commited
unlisted=$(grep -Fxvf <(echo "$to_install") <(echo "$installed"))

not_installed=()

for package in $to_install; do
  if ! pacman -Q "$package" >/dev/null 2>&1; then
    not_installed+=("$package")
  fi
done

printf "%s\n" "${not_installed[@]}"
echo ""
echo -e "$unlisted"
