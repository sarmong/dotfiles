#!/usr/bin/env bash

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$script_dir" || exit 1

log_dir="$script_dir/logs"
[ ! -d "$log_dir" ] && mkdir "$log_dir"

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

failed_packages=()

install() {
  IFS=$' '
  command="$1"
  package="$2"
  echo -e "$green Installing $bi_cyan$package$nocol..."
  if ! $command "$package" >>"$log_dir"/output.log 2>>"$log_dir"/errors.log; then
    echo -e "$red An error occured"
    failed_packages+=("$package")
  else
    echo -e "$green Successfully installed $bi_cyan$package$nocol"
  fi
}

pac() {
  install "sudo pacman -S --noconfirm --needed" "$1"
}

aur() {
  install "paru -S --noconfirm --needed" "$1"
}

finalize() {
  echo -e "\n"
  echo -e "$red The following packages failed to install: $nocol"
  printf "%s\n" "${failed_packages[@]}" | tee -a "$log_dir"/errors.log
}

install_paru() {
  if command -v paru >/dev/null; then
    echo -e "$red Paru already installed$nocol"
    return
  fi

  echo -e "$green Installing paru... $nocol"

  mkdir -p ~/.local/src
  cd ~/.local/src || exit 1
  git clone https://aur.archlinux.org/paru.git >>"$log_dir"/output.log
  cd paru || exit 1
  makepkg --noconfirm -si >>"$log_dir"/output.log
  cd "$script_dir" || exit 1
}

trap 'finalize && exit 1' SIGTERM SIGINT SIGQUIT

sudo pacman -Syy
install_paru

to_install=$(sed 's/#.*$//g' "./arch.txt" | sed '/^$/d')

IFS=$'\n'
for package in $to_install; do
  flag=$(echo "$package" | awk '{ print $2 }')
  package_name=$(echo "$package" | awk '{ print $1 }')

  if [ "$flag" = "a" ]; then
    aur "$package_name"
  else
    pac "$package_name"
  fi
done

finalize
