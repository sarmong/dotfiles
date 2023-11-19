#!/bin/sh

sudo ln -sfT /bin/dash /bin/sh

"$XDG_BIN_DIR"/services/ufw/init.sh
"$XDG_BIN_DIR"/services/lightdm/init.sh
"$XDG_BIN_DIR"/services/keyd/init.sh
"$XDG_BIN_DIR"/services/suspend/init.sh
"$XDG_BIN_DIR"/services/audio/init.sh
"$XDG_BIN_DIR"/services/cron/init.sh

"$XDG_BIN_DIR"/setup/touchpad/init.sh

sudo systemctl enable NetworkManager
sudo systemctl enable auto-cpufreq
sudo systemctl enable bluetooth
sudo systemctl enable cronie
sudo systemctl enable betterlockscreen@"$USER"
sudo systemctl enable syncthing@"$USER"

sudo gpasswd -a "$USER" input
# This command seems to create a new shell and
# the execution of the following commands stops until you manually exit.
# It might be not needed. If libinput-gestures still don't work,
# I'll need to find a different solution. Adding `&& exit` seems to not help either.
## newgrp input

tldr --update
fnm install lts/latest
fnm default lts/latest
chsh -s "$(which zsh)"
chsh -s "$(which zsh)" "$(whoami)"

Xvfb &
betterlockscreen -u "$XDG_DOTFILES_DIR/assets/lockscreen.png"
luna.sh

os=$(grep -oP '^ID=\K\w+' </etc/os-release)

if [ "$os" = 'debian' ]; then
  ln -s "/media/$USER" "$HOME/drives"
elif [ "$os" = 'arch' ]; then
  ln -s "/run/media/$USER" "$HOME/drives"
fi
