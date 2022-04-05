#!/usr/bin/env sh

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

# @TODO combine into one function
aptinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	sudo apt-get install --yes "$input" 1>/dev/null
	if [ $? -gt 0 ]; then
		echo "$red An error occured"
		exit 1
	fi

	echo "$green Successfully installed $bi_cyan $input $nocol"
}

flatinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	flatpak install flathub -y "$input" 1>/dev/null
	if [ $? -gt 0 ]; then
		echo "$red An error occured"
		exit 1
	fi

	echo "$green Successfully installed $bi_cyan $input $nocol"
}

brewinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	brew install "$input" 1>/dev/null
	if [ $? -gt 0 ]; then
		echo "$red An error occured"
		exit 1
	fi

	echo "$green Successfully installed $bi_cyan $input $nocol"
}

pacinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	pacstall -IP "$input" 1>/dev/null
	if [ $? -gt 0 ]; then
		echo "$red An error occured"
		exit 1
	fi

	echo "$green Successfully installed $bi_cyan $input $nocol"
}

alert() {
	echo "$green -----------------------------------------------------------------"
	echo "$1"
	echo "-----------------------------------------------------------------$nocol"
}

sudo apt update && sudo apt upgrade
alert "REPOS UPDATED AND PACKAGES UPGRADED"

### --- Essentials --- ###
aptinst git
aptinst curl
aptinst vim

### --- Install installers --- ###

## Pacstall
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"

pacstall -A https://raw.githubusercontent.com/sarmong/pacstall-sarmong/master

## Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) # put brew into PATH
# @TODO check if this line needed
# aptinst build-essential

## flatpak
sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
aptinst flatpak
sudo apt install --reinstall ca-certificates # this fixes tsl error with flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

alert "INSTALLED INSTALLERS"

### --- Install packages --- ###

aptinst blueman bluez bluetooth # Blueman is a GUI for bluez

aptinst pnmixer     # Volume System Tray
aptinst pulsemixer  # Pulse Audio TUI
aptinst pavucontrol # Pulse Audio Volume Control GUI
aptinst pasystray   # Pulse Audio System Tray
aptinst pamix       # Pulse Audio TUI

aptinst udiskie # Automounts external drives
pacinst picom

### --- Main system setup --- ###

pacinst awesome-git
aptinst i3lock-fancy
aptinst arandr
aptinst lxappearance
aptinst xfce4-power-manager
aptinst network-manager-gnome network-manager-openvpn-gnome
aptinst mate-system-monitor
pacinst xkblayout-state-git
flatpak install flathub org.chromium.Chromium

## Brave browser
aptinst apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
aptinst brave-browser

aptinst trash-cli
aptinst stow
pacinst rofi
pacinst rofi-calc
brewinst libqalculate # needed for rofi-calc. Brew has newer version
aptinst copyq

sudo add-apt-repository ppa:touchegg/stable
sudo apt update
aptinst touchegg

aptinst feh
aptinst zathura
aptinst zathura-djvu
aptinst flameshot

pacinst alacritty

aptinst xclip
aptinst tlp powertop
aptinst brightnessctl
aptinst xcape
aptinst xdotool
aptinst playerctl
pacinst keyd

alert "INSTALLED MAIN SYSTEM SETUP"

### --- Programming tools --- ###
## needed for treesitter
aptinst gcc
aptinst g++
pacinst neovim
sudo add-apt-repository universe
aptinst fonts-firacode

## Install system version of node
pacstall nodejs-lts-deb
## Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
npm i -g yarn
aptinst httpie
flatinst com.getpostman.Postman
pacinst lazynpm-bin
pacinst lazygit-bin
pacinst tig
aptinst zeal # Documentation browser

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
aptinst gh

## VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
aptinst codium

aptinst tldr
aptinst shellcheck

## LSPs
nvm use system
npm i -g typescript typescript-language-server
brewinst lua-language-server
brewinst hashicorp/tap/terraform-ls

## Formatters
npm install -g @fsouza/prettierd
npm install -g stylelint
brewinst stylua
brewinst shfmt
brewinst markdownlint-cli

alert "INSTALLED PROGRAMMING TOOLS"

###############################################

### --- Useful CLI utils --- ###

aptinst tree
aptinst exiftool
aptinst ffmpeg
aptinst imagemagick
aptinst speedtest-cli
aptinst watch
aptinst htop
aptinst scrot
aptinst colordiff
pacinst fzf-bin
pacinst fd-deb
pacinst bat-deb
pacinst yt-dlp-bin
pacinst ytfzf
pacinst ripgrep-deb
aptinst thefuck
curl -sS https://webinstall.dev/zoxide | bash
aptinst atool
brewinst massren
pacinst dragon-drop
pacinst handlr-bin

## TUIs
aptinst pass
pacinst newsboat
# aptinst cmus
# brewinst ddgr # duckduckgo from terminal
# aptinst gnu-typist
# aptinst ledger
# aptinst calcurse
# aptinst timewarrior
# aptinst taskwarrior
# brewinst inetutils

### --- Install Applications --- ###

aptinst kazam
aptinst safeeyes
aptinst redshift redshift-gtk
aptinst goldendict
aptinst thunderbird
flatinst com.skype.Client
pacinst slack-deb
pacisnt zoom-deb
flatinst org.telegram.desktop
aptinst qbittorrent

sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt-get update
aptinst nextcloud-client

curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
aptinst spotify-client
aptinst anki

# aptinst bitwarden
# aptinst gramps
# aptinst stretchly

aptinst djview
# aptinst virtualbox
# aptinst gimp
pacinst mpv
# aptinst musescore

aptinst neofetch
# aptinst cmatrix
# aptinst figlet
# aptinst espeak

alert "FINISHED"
