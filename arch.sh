#!/usr/bin/env sh

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

pacinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	pacman -S "$input" 1>/dev/null
	if [ $? -gt 0 ]; then
		echo "$red An error occured"
		exit 1
	fi

	echo "$green Successfully installed $bi_cyan $input $nocol"
}

yayinst() {
	input="$1"
	echo "$green Installing $bi_cyan $input $nocol ..."
	paru -S "$input" 1>/dev/null
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

pacman -Syyyu

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

alert "REPOS UPDATED AND PACKAGES UPGRADED"

### --- Essentials --- ###
pacinst git
pacinst curl wget
pacinst vim
pacinst stow
pacinst openssh

### --- Install packages --- ###

### --- Main system setup --- ###

pacinst xorg-server
pacinst xorg-setxkbmap xorg-xinit xorg-xev xorg-xkill xorg-xprop xorg-xrandr xorg-xset xorg-xinit

pacinst lightdm lightdm-slick-greeter

yayinst awesome-git
yayinst i3lock-fancy-git
pacinst picom
pacinst arandr

## Themes
pacinst lxappearance
yayinst gtk-theme-arc-gruvbox-git
pacinst python-qdarkstyle # provides a dark Qt theme.

## Fonts
pacinst noto-fonts-emoji
yayinst nerd-fonts-mononoki
pacinst otf-font-awesome
pacinst ttf-font-awesome
yayinst nerd-fonts-fira-code

## Keyboard
yayinst keyd-git
yayinst xkblayout-state-git

## Audio
yayinst pnmixer     # Volume System Tray
pacinst pulsemixer  # Pulse Audio TUI
pacinst pavucontrol # Pulse Audio Volume Control GUI
pacinst pamixer     # Pulse Audio TUI
pacinst playerctl

pacinst blueman bluez # Blueman is a GUI for bluez

pacinst network-manager-applet

# pacinst gnome-keyring

pacinst xfce4-power-manager
pacinst mate-system-monitor
pacinst udiskie # Automounts external drives

yayinst spacefm
pacinst lf
pacinst ueberzug

pacinst trash-cli

pacinst dmenu
pacinst rofi
pacinst rofi-calc
pacinst libqalculate # needed for rofi-calc. Brew has newer version

pacinst copyq

yayinst touchegg

pacinst feh
pacinst perl-image-exiftool
pacinst zathura zathura-pdf-mupdf zathura-djvu
pacinst flameshot
pacinst scrot
pacinst mpv

pacinst alacritty

pacinst xclip
pacinst tlp powertop
pacinst brightnessctl

pacinst newsboat

### --- Useful CLI utils --- ###

pacinst ffmpeg
pacinst imagemagick

pacinst jq
pacinst tree
pacinst speedtest-cli
pacinst htop
pacinst colordiff
pacinst fzf
pacinst fd
pacinst bat
pacinst yt-dlp
yayinst ytfzf
pacinst ripgrep
pacinst thefuck
pacinst zoxide
yayinst atool
pacinst unrar unzip
yayinst massren
yayinst dragon-drop
yayinst handlr-bin
pacinst neofetch
pacinst xdotool

pacinst pass

alert "INSTALLED MAIN SYSTEM SETUP"

###############################################

### --- Programming tools --- ###
pacinst neovim

## Install system version of node
pacstall nodejs-lts-gallium
## Install nvm
yayinst nvm
npm i -g yarn
pacinst httpie
yayinst postman-bin
yayinst lazynpm-bin
pacinst lazygit
pacinst tig
yayinst zeal # Documentation browser

sudo apt install github-cli

yayinst vscodium-bin

pacinst tldr
pacinst shellcheck

## LSPs
npm i -g typescript typescript-language-server
pacinst lua-language-server
yayinst terraform-ls

## Formatters
npm install -g @fsouza/prettierd
npm install -g stylelint
pacinst stylua
pacinst shfmt
yayinst nodejs-markdownlint-cli

alert "INSTALLED PROGRAMMING TOOLS"

### --- Install Applications --- ###

yayinst safeeyes
pacinst redshift
yayinst redshift-gtk

pacinst firefox
yayinst brave-bin
pacinst chromium

yayinst kazam
yayinst goldendict-git
yayinst skypeforlinux-stable-bin
yayinst slack-desktop
yayisnt zoom-deb
pacinst telegram-desktop
pacinst qbittorrent

pacinst nextcloud-client

yayinst spotify
yayinst anki

# pacinst thunderbird
# pacinst bitwarden
# pacinst gramps
# pacinst stretchly

# pacinst virtualbox
# pacinst gimp
# pacinst musescore

# pacinst cmatrix
# pacinst figlet
# pacinst espeak

# pacinst cmus
# brewinst ddgr # duckduckgo from terminal
# pacinst gnu-typist
# pacinst ledger
# pacinst calcurse
# pacinst timewarrior
# pacinst taskwarrior
# brewinst inetutils

alert "FINISHED"
