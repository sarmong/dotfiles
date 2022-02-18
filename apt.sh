#!/usr/bin/env sh

### --- Install installers --- ###

## Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# @TODO check if this line needed
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

## flatpak
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

### --- Install packages --- ###

sudo apt install blueman bluez bluetooth # Blueman is a GUI for bluez

### --- Main system setup --- ###

sudo apt install awesome
# sudo apt install i3
# sudo apt install i3blocks
sudo apt install i3lock-fancy
sudo apt install arandr
sudo apt install lxappearance
# flatpak install flathub com.github.Eloston.UngoogledChromium
sudo apt install brave-browser
sudo apt install trash-cli
sudo apt istall stow
sudo apt install ranger
sudo apt install rofi
# sudo apt install tint2
sudo apt install copyq

sudo apt install feh
sudo apt install flameshot

## kitty installation
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in your PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

# @TODO check if needed
sudo apt install xclip
sudo apt install tlp powertop xbacklight
sudo apt install xcape
sudo apt install xdotool

### --- Programming tools --- ###
brew install neovim
sudo apt install fonts-firacode

## Install system version of node
brew install node@16
## Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
npm i -g yarn
sudo apt install gh
sudo apt install httpie
flatpak install flathub com.getpostman.Postman
brew install jesseduffield/lazynpm/lazynpm
brew install tig
brew install jesseduffield/lazygit/lazygit
sudo apt install zeal # Documentation browser

sudo snap install sublime-text --classic
## VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium

sudo apt install tldr
sudo apt install shellcheck

## LSPs
nvm use system
npm i -g typescript typescript-language-server
brew install lua-language-server
brew install hashicorp/tap/terraform-ls

## Formatters
npm install -g @fsouza/prettierd
npm install -g stylelint
brew install stylua
brew install shfmt
brew install markdownlint-cli

###############################################

sudo apt install zathura

### --- Useful CLI utils --- ###

sudo apt install tree
sudo apt install exiftool
sudo apt install ffmpeg
sudo apt install imagemagick
sudo apt install speedtest-cli
sudo apt install autojump
sudo apt install watch
sudo apt install htop
sudo apt install scrot
brew install fzf
brew install fd
brew install broot
brew install bat
brew install youtube-dl
brew install rigpgrep
brew install thefuck

## TUIs
sudo apt install pass
# sudo apt install cmus
# sudo apt install newsboat
# brew install ddgr # duckduckgo from terminal
# sudo apt install gnu-typist
# sudo apt install ledger
# sudo apt install calcurse
# sudo apt install timewarrior
# sudo apt install taskwarrior
# brew install inetutils

### --- Install Applications --- ###

sudo apt install kazam
sudo apt install safeeyes
sudo apt install screenkey
sudo apt install stardict
sudo apt install goldendict
sudo apt install thunderbird
sudo snap install skype
sudo snap install slack --classic
sudo snap install zoom-client
flatpak install flathub org.telegram.desktop
flatpak install flathub com.nextcloud.desktopclient.nextcloud
# sudo apt install spotify

# sudo apt install bitwarden
# sudo apt install gramps
# sudo apt install stretchly

sudo apt install djview
# sudo apt install virtualbox
# sudo apt install gimp
sudo apt install mpv
# sudo apt install vlc
# sudo apt install musescore

## fun
sudo apt install neofetch
# sudo apt install cmatrix
# sudo apt install figlet
# sudo apt install espeak

echo "Now manually build the following apps: "
echo "dragon, jgmenu, keyd, picom"

## @TODO check if used
# sudo apt install lua5.2
