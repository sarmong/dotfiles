#!/usr/bin/env bash

user="michael"

if ! id -u "$user"; then
  adduser "$user"
  adduser "$user" sudo

  read -r -p "Do you want to add www user? [y/N]" yn
  if [ "$yn" = "Y" ] || [ "$yn" = "y" ]; then
    adduser www
    mkdir /var/www
    chown www:www /var/www
    echo "Added www user."
  fi

  echo "Created user.
  1. exit
  2. ssh-copy-id -i ~/.ssh/key $user@[ip]
  3. ssh-copy-id -i ~/.ssh/wwwkey www@[ip]
  3. ssh $user@[ip]
  4. Run this file again
  "
  exit 0
fi

echo "Cloning dotfiles...."

mkdir ~/docs
cd ~/docs || exit

git clone https://github.com/sarmong/dotfiles.git
cd dotfiles || exit

echo "Updating sudo to use vim by default"

echo "Defaults      editor=/usr/bin/vim, !env_editor" | (sudo su -c 'EDITOR="tee" visudo -f /etc/sudoers.d/editor')

echo "Updating sshd_config with the following values:"

echo "
PermitRootLogin no
PasswordAuthentication no
X11Forwarding no" | sudo tee -a /etc/ssh/sshd_config

sudo systemctl reload sshd

echo "Installing packages: "

sed 's/#.*$//g' ./server/debian.txt | sed '/^$/d' | xargs sudo apt install -y

## Firewall

echo "Enabling firewall..."

sudo ufw allow 'OpenSSH'
sudo ufw allow 'Nginx Full'
sudo ufw allow 80,443/tcp
sudo ufw enable

echo "Linking files..."

./link.sh

echo "Changing shell to zsh..."

chsh -s /usr/bin/zsh

echo "Adding user to docker group..."

sudo usermod -aG docker "$USER"
newgrp docker # applies the changes to the group

echo "Open another terminal window and check if you can login"
