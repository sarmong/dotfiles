#!/usr/bin/env sh

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

pacinst() {
  input="$*"
  echo -e "$green Installing $bi_cyan $input $nocol ..."
  sudo pacman -S --noconfirm $input 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "$red An error occured"
    exit 1
  fi

  echo -e "$green Successfully installed $bi_cyan $input $nocol"
}

yayinst() {
  input="$*"
  echo -e "$green Installing $bi_cyan $input $nocol ..."
  paru -S --noconfirm $input 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "$red An error occured"
    exit 1
  fi

  echo -e "$green Successfully installed $bi_cyan $input $nocol"
}

alert() {
  echo -e "$green -----------------------------------------------------------------"
  echo -e "$1"
  echo -e "-----------------------------------------------------------------$nocol"
}

sudo pacman -Syyyu

sudo pacman -S --needed base-devel
mkdir -p ~/.local/src
cd ~/.local/src
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

alert "REPOS UPDATED AND PACKAGES UPGRADED"

### --- Essentials --- ###
pacinst git
pacinst curl wget
pacinst vim neovim
curl -fLo "$XDG_DATA_HOME"/vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pacinst stow
pacinst openssh
pacinst man-db man-pages
pacinst mlocate
pacinst zsh
pacinst dash
ln -sfT /bin/dash /bin/sh

pacinst ufw
"$XDG_BIN_DIR"/services/ufw/init.sh

### --- Install packages --- ###

### --- Main system setup --- ###

pacinst xorg-server
pacinst xorg-setxkbmap xorg-xinit xorg-xev xorg-xkill xorg-xprop xorg-xrandr xorg-xset xorg-xinput
pacinst xdotool
pacinst wmctrl
yayinst wmutils-git
pacinst xdo

pacinst lightdm lightdm-slick-greeter
"$XDG_BIN_DIR"/services/lightdm/init.sh

yayinst awesome-git
pacinst bspwm sxhkd polybar dunst
yayinst eww
yayinst i3lock-fancy-git
pacinst picom
pacinst arandr
pacinst autorandr
pacinst lxsession

## Themes
pacinst lxappearance
yayinst gtk-theme-arc-gruvbox-git
pacinst papirus-icon-theme
pacinst qt5ct
yayinst adwaita-qt6-git
yayinst adwaita-qt5-git

## Fonts
pacinst noto-fonts
pacinst otf-font-awesome
yayinst nerd-fonts-complete
pacinst font-manager
pacinst noto-fonts-emoji # provide emojis for terminal and polybar
# yayinst ttf-twemoji
# pacinst ttf-joypixels

## Keyboard
yayinst keyd-git
"$XDG_BIN_DIR"/services/keyd/init.sh
yayinst xkblayout-state-git
yayinst inputplug

## Audio
pacinst pulseaudio  # Main package
yayinst volctl      # Volume System Tray
pacinst pulsemixer  # Pulse Audio TUI
pacinst pavucontrol # Pulse Audio Volume Control GUI
pacinst pamixer     # Pulse Audio CLI
pacinst playerctl

pacinst blueman bluez bluez-utils # Blueman is a GUI for bluez

pacinst network-manager-applet
pacinst gnome-keyring # Should start systemd service automatically

pacinst xfce4-power-manager
pacinst mate-system-monitor
pacinst bottom
pacinst conky
pacinst udiskie # Automounts external drives

pacinst caja
pacinst xarchiver
yayinst lf
pacinst ueberzug

pacinst trash-cli

pacinst dmenu
pacinst rofi
pacinst rofi-calc
pacinst libqalculate # needed for rofi-calc. Brew has newer version

yayinst clipmenu-git

yayinst libinput-gestures
sudo gpasswd -a "$USER" input
# This command seems to create a new shell and
# the execution of the following commands stops until you manually exit.
# It might be not needed. If libinput-gestures still don't work,
# I'll need to find a different solution. Adding `&& exit` seems to not help either.
## newgrp input

pacinst feh
yayinst nsxiv
pacinst perl-image-exiftool
pacinst zathura zathura-pdf-mupdf zathura-djvu
pacinst pandoc
pacinst flameshot
pacinst scrot
pacinst mpv
yayinst mpvc-git

pacinst alacritty
pacinst tmux

pacinst xclip
pacinst powertop
yayinst auto-cpufreq
sudo systemctl enable auto-cpufreq.service
pacinst brightnessctl

pacinst newsboat
pacinst urlscan

### --- Useful CLI utils --- ###

pacinst ffmpeg
pacinst ffmpegthumbnailer
pacinst imagemagick
pacinst lynx

pacinst jq
pacinst tree
pacinst speedtest-cli
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
pacinst unrar unzip zip
# yayinst massren
pacinst moreutils # Provides vidir packages for mass renaming
pacinst fdupes
yayinst dragon-drop
pacinst handlr
pacinst perl-file-mimeinfo
yayinst selectdefaultapplication-git
pacinst neofetch
pacinst unclutter
pacinst dua-cli
pacinst uglify-js

pacinst pass

alert "INSTALLED MAIN SYSTEM SETUP"

###############################################

### --- Programming tools --- ###
## Install system version of node
pacinst nodejs
yayinst fnm-bin
sudo npm i -g yarn
pacinst httpie
yayinst postman-bin
pacinst tig
yayinst zeal # Documentation browser

pacinst github-cli

yayinst vscodium-bin

pacinst tldr
pacinst shellcheck

alert "INSTALLED PROGRAMMING TOOLS"

### --- Install Applications --- ###

yayinst safeeyes
pacinst activitywatch-bin
pacinst xprintidle
pacinst redshift
# yayinst redshift-gtk

pacinst firefox
yayinst brave-bin
pacinst chromium
yayinst surf

yayinst kazam
yayinst goldendict-git
yayinst skypeforlinux-stable-bin
yayinst slack-desktop
yayinst zoom
pacinst telegram-desktop
pacinst qbittorrent
yayinst webcamoid

pacinst nextcloud-client

yayinst spotify
yayinst anki

pacinst neofetch onefetch

alert "FINISHED"
