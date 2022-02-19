#!/usr/bin/env sh

green='\e[0;32m'

alias aptinst="sudo apt install --yes"
alias brewinst="brew install"
alias flatinst="flatpak install flathub -y"

sudo apt update && sudo apt upgrade

echo "-----------------------------------------------------------------"
echo "$green REPOS UPDATED AND PACKAGES UPGRADED"
echo "-----------------------------------------------------------------"

### --- Essentials --- ###
aptinst curl
aptinst vim
aptinst git

### --- Install installers --- ###

## Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) # put brew into PATH
# @TODO check if this line needed
# aptinst build-essential

## flatpak
aptinst flatpak
sudo apt install --reinstall ca-certificates # this fixes tsl error with flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "-----------------------------------------------------------------"
echo "$green INSTALLED INSTALLERS"
echo "-----------------------------------------------------------------"

### --- Install packages --- ###

aptinst blueman bluez bluetooth # Blueman is a GUI for bluez

### --- Main system setup --- ###

aptinst awesome
# aptinst i3
# aptinst i3blocks
aptinst i3lock-fancy
aptinst arandr
aptinst lxappearance
flatinst com.github.Eloston.UngoogledChromium

## Brave browser
sudo apt install apt-transport-https curl
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

echo "-----------------------------------------------------------------"
echo "$green INSTALLED MAIN SYSTEM SETUP"
echo "-----------------------------------------------------------------"

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

echo "-----------------------------------------------------------------"
echo "$green INSTALLED PROGRAMMING TOOLS"
echo "-----------------------------------------------------------------"

###############################################

### --- Useful CLI utils --- ###

aptinst tree
aptinst exiftool
aptinst ffmpeg
aptinst imagemagick
aptinst speedtest-cli
aptinst autojump
aptinst watch
aptinst htop
aptinst scrot
brewinst fzf
brewinst fd
brewinst broot
brewinst bat
brewinst youtube-dl
brewinst rigpgrep
brewinst thefuck

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
aptinst stardict
aptinst goldendict
aptinst thunderbird
sudo snap install skype
sudo snap install slack --classic
sudo snap install zoom-client
flatinst org.telegram.desktop
flatinst com.nextcloud.desktopclient.nextcloud
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

echo "-----------------------------------------------------------------"
echo "$green FINISHED"
echo "-----------------------------------------------------------------"

echo "Now manually build the following apps: "
echo "dragon, jgmenu, keyd, picom"

## @TODO check if used
# aptinst lua5.2
