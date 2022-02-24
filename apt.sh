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
## Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### --- Install installers --- ###

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

### --- Main system setup --- ###

aptinst awesome
# aptinst i3
# aptinst i3blocks
aptinst i3lock-fancy
aptinst arandr
aptinst lxappearance
# flatinst com.github.Eloston.UngoogledChromium
aptinst chromium-browser

## Brave browser
aptinst apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
aptinst brave-browser

aptinst trash-cli
aptinst stow
aptinst ranger
aptinst rofi
# aptinst tint2
aptinst copyq

aptinst feh
aptinst zathura
aptinst flameshot

## kitty installation
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in your PATH)
mkdir ~/.local/bin && ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

aptinst xclip
aptinst tlp powertop xbacklight
aptinst xcape
aptinst xdotool

alert "INSTALLED MAIN SYSTEM SETUP"

### --- Programming tools --- ###
## needed for treesitter
aptinst gcc
aptinst g++
brewinst neovim
sudo add-apt-repository universe
aptinst fonts-firacode

## Install system version of node
brewinst node@16
PATH="/home/linuxbrew/.linuxbrew/opt/node@16/bin:$PATH"
## Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
npm i -g yarn
aptinst httpie
flatinst com.getpostman.Postman
brewinst jesseduffield/lazynpm/lazynpm
brewinst tig
brewinst jesseduffield/lazygit/lazygit
brewinst gh
aptinst zeal # Documentation browser

sudo snap install sublime-text --classic
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
brewinst fzf
brewinst fd
brewinst broot
brewinst bat
brewinst youtube-dl
brewinst yt-dlp
brewinst ripgrep
brewinst thefuck
brewinst zoxide

## TUIs
aptinst pass
# aptinst cmus
# aptinst newsboat
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
aptinst screenkey
aptinst redshift
aptinst goldendict
aptinst thunderbird
sudo snap install skype
sudo snap install slack --classic
sudo snap install zoom-client
flatinst org.telegram.desktop

sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt-get update
aptinst nextcloud-client

# aptinst spotify

# aptinst bitwarden
# aptinst gramps
# aptinst stretchly

aptinst djview
# aptinst virtualbox
# aptinst gimp
aptinst mpv
# aptinst vlc
# aptinst musescore

## fun
aptinst neofetch
# aptinst cmatrix
# aptinst figlet
# aptinst espeak

alert "FINISHED"

echo "Now manually build the following apps: "
echo "dragon, jgmenu, keyd, picom"
