#!/bin/sh

## Users

user="michael"

echo "Creating user..."
useradd --shell "$(which zsh)" --create-home --home-dir "/home/$user" --comment "$user" --user-group --groups sudo -- "$user"

echo "Adding password..."
passwd "$user"

echo "Changing user..."
su "$user"

## Dotfiles

cd && mkdir docs && cd docs || exit 1

git clone https://github.com/sarmong/dotfiles.git

cd dotfile || exit 1

./setup.sh

## Firewall

echo "Enabling firewall..."

sudo ufw allow 'OpenSSH'
sudo ufw allow 'Nginx Full'
sudo ufw allow 80,443/tcp
sudo ufw enable

## Neovim

mkdir -p ~/.local/src && cd ~/.local/src || exit 1

curl --location --remote-name https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb
curl --location --remote-name https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb.sha256sum
if ! sha256sum --check nvim-linux64.deb.sha256sum; then
  echo "Shasums do not match!"
else
  sudo apt install ./nvim-linux64.deb
fi

## Docker

sudo usermod -aG docker "$USER"
newgrp docker # applies the changes to the group
