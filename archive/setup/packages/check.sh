#!/usr/bin/env bash

cyan='\e[1;96m'
nocol='\e[0m'

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir" || exit 1

os=$(grep -oP '^ID=\K\w+' </etc/os-release)

packages_file="$script_dir/packages.tsv"
package_data=$(sed 's/#.*$//g' "$packages_file" | sed '/^$/d' | sed 1d)

if [ "$os" = 'arch' ]; then
  installed=$(pacman -Qqe | sort)
  to_install=$(echo "$package_data" | awk -F$'\t' '{ if ($4 != "x") print ($3 == "" ? $1 : $3) }' | sort)
elif [ "$os" = 'debian' ]; then
  installed=$(apt-mark showmanual | sed 's/-git\-bin//g' | sort)
  to_install=$(echo "$package_data" | awk -F$'\t' '{  if ($2 != "x") print $1 }' | sed 's/-git\-bin//g' | sort)
fi

## installed but not commited
unlisted=$(grep -Fxvf <(echo "$to_install") <(echo "$installed"))

not_installed=()

for package in $to_install; do
  if ! pacman -Qe "$package" >/dev/null 2>&1; then
    not_installed+=("$package")
  fi
done

echo -e "${cyan}Packages that are listed but not installed:${nocol}"
printf "%s\n" "${not_installed[@]}"
echo ""
echo -e "${cyan}Packages that are installed but not listed:${nocol}"
echo -e "$unlisted"
