#!/bin/bash

# execute brew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

# Install sudo apt Packages

# basic
sudo apt install i3
sudo apt install i3blocks
sudo apt install i3lock-fancy
brew install neovim

## install system version of node
brew install node@16
## install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
sudo apt install neofetch

sudo apt install zathura

# cli utils
sudo apt install tree
# sudo apt install broot
brew install bat
sudo apt install exiftool
sudo apt install ffmpeg
sudo apt install imagemagick
sudo apt install speedtest-cli
brew install youtube-dl
sudo apt install autojump
# sudo apt install fd
brew install fzf
sudo apt install watch
sudo apt install scrot
sudo apt install xclip
sudo apt install tlp powertop xbacklight
brew install rigpgrep
sudo apt istall stow
brew install thefuck
sudo apt install httpie
sudo apt install copyq

# sudo apt install cheat
sudo apt install tldr
sudo apt install shellcheck
# sudo apt install checkbashisms
npm i -g yarn

# terminal-based apps
# sudo apt install bitwarden-cli
sudo apt install cmus
sudo apt install htop # show processes
sudo apt install neovim
sudo apt install newsboat
sudo apt install ranger
sudo apt install ddgr
# sudo apt install gnu-typist
sudo apt install ledger
sudo apt install calcurse
sudo apt install timewarrior
sudo apt install taskwarrior
brew install jesseduffield/lazynpm/lazynpm
brew install tig
brew install jesseduffield/lazygit/lazygit

# fun
sudo apt install cmatrix
sudo apt install figlet
sudo apt install espeak

# other
# sudo apt install inetutils

# Install Applications

sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# sudo apt install eloston-chromium  # ungoogled-chromium
sudo snap install brave
sudo apt install thunderbird
sudo snap install nextcloud
#sudo apt install obsidian
sudo snap install skype
sudo snap install slack --classic
sudo snap install zoom-client
# sudo apt install spotify
sudo apt install telegram

# sudo apt install bitwarden
# sudo apt install gramps
# sudo apt install stretchly

sudo snap install sublime-text --classic
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium

sudo apt install djview
sudo apt install virtualbox
sudo apt install gimp
sudo apt install mpv
sudo apt install vlc
sudo apt install musescore
sudo apt install vienna

sudo apt install kitty

sudo apt install lua5.2
sudo apt install feh
sudo apt install trash-cli
sudo apt install flameshot
sudo apt install goldendict

# LSPs
nvm use system
npm i -g typescript typescript-language-server
brew install lua-language-server
brew install hashicorp/tap/terraform-ls

## Formatters
npm install -g @fsouza/prettierd
npm install -g stylelint
brew install stylua
brew install shfmt
