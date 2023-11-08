#!/usr/bin/env bash
# shellcheck disable=2181,2129

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

# shellcheck disable=1007
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

log_dir="$script_dir/logs"
[ ! -d "$log_dir" ] && mkdir "$log_dir"

os=$(grep -oP '^ID=\K\w+' </etc/os-release)

pac() {
  install "sudo pacman -S --noconfirm --needed" "$1"
}

aur() {
  install "paru -S --noconfirm --needed" "$1"
}

apt() {
  install "apt-get install" "$1"
}

pstall() {
  install "pacstall -I" "$1"
}

nix() {
  install "nix-env --install --attr" "nixpkgs.$1"
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

install_pacstall() {
  if command -v pacstall >/dev/null; then
    echo -e "$red Pacstall already installed$nocol"
    return
  fi

  echo -e "$red Pacstall not found, downloading the script:$nocol"
  curl -fSL https://pacstall.dev/q/install -o ./pacstall-install.sh
  chmod +x ./pacstall-install.sh
  echo -e "$green Now, manually VERIFY the script and run:"
  echo -e "$bi_cyan sudo bash -c ./pacstall-install.sh"
  exit 1
}

install_nix() {
  if command -v nix-env >/dev/null; then
    echo -e "$red Nix already installed$nocol"
    return
  fi

  echo -e "$red Nix not found, downloading the script:$nocol"
  curl -L https://nixos.org/nix/install -o ./nix-install.sh
  echo -e "$green Now, manually VERIFY the script and run:"
  echo -e "$bi_cyan sh ./nix-install.sh --daemon"
  exit 1
}

install() {
  IFS=$' '
  command="$1"
  package="$2"
  echo -e "$green Installing $bi_cyan$package$nocol..."
  if ! $command "$package" >>"$log_dir"/output.log 2>>"$log_dir"/errors.log; then
    echo -e "$red An error occured"
    return 1
  else
    echo -e "$green Successfully installed $bi_cyan$package$nocol"
  fi
}

trap 'finalize && exit 1' SIGTERM SIGINT SIGQUIT

cd "$script_dir" || exit 1

if [ "$os" = 'arch' ]; then
  packages_file="./arch.txt"

  sudo pacman -Syy
  install_paru
elif [ "$os" = 'debian' ]; then
  packages_file="./debian.txt"

  install_pacstall
  pacstall -A https://raw.githubusercontent.com/sarmong/pacstall-sarmong/master
  install_nix
else
  echo "$red $os is not currently supported"
  exit 1
fi

to_install=$(sed 's/#.*$//g' "$packages_file" | sed '/^$/d')

failed_packages=()
installed_packages=()

IFS=$'\n'
for package in $to_install; do
  flag=$(echo "$package" | awk '{ print $2 }')
  package_name=$(echo "$package" | awk '{ print $1 }')

  if [ "$os" = 'arch' ]; then
    if [ "$flag" = "a" ]; then
      aur "$package_name"
    else
      pac "$package_name"
    fi
  fi

  if [ "$os" = 'debian' ]; then
    if [ "$flag" = "x" ]; then
      continue
    fi

    if [ "$flag" = "n" ]; then
      nix "$package_name"
    elif [ "$flag" = "p" ]; then
      pstall "$package_name"
    else
      apt "$package_name"
    fi
  fi

  if [ $? -gt 0 ]; then
    failed_packages+=("$package")
  else
    installed_packages+=("$package")
  fi
done

finalize() {
  echo -e "\n"
  echo -e "$red The following packages failed to install: $nocol"
  printf "FAILED: \n\n" >>"$log_dir"/packages.log
  printf "%s\n" "${failed_packages[@]}" | tee -a "$log_dir"/packages.log

  printf "\nINSTALLED: \n\n" >>"$log_dir"/packages.log
  printf "%s\n" "${installed_packages[@]}" >>"$log_dir"/packages.log

  printf "\nNOT INSTALLED: \n\n" >>"$log_dir"/packages.log
  grep -Fxvf <(printf "%s\n" "${installed_packages[@]}") <(echo "$to_install") >>"$log_dir"/packages.log
}

finalize
