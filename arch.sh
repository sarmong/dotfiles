#!/usr/bin/env sh

# https://stackoverflow.com/questions/16843382/colored-shell-script-output-library
red='\e[0;31m'
green='\e[0;32m'
bi_cyan='\e[1;96m'
nocol='\e[0m' # Text Reset

pacinst() {
  input="$*"
  echo "$green Installing $bi_cyan $input $nocol ..."
  sudo pacman -S --noconfirm $input 1>/dev/null
  if [ $? -gt 0 ]; then
    echo "$red An error occured"
    exit 1
  fi

  echo "$green Successfully installed $bi_cyan $input $nocol"
}

yayinst() {
  input="$*"
  echo "$green Installing $bi_cyan $input $nocol ..."
  paru -S --noconfirm $input 1>/dev/null
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
pacinst vim neovim
curl -fLo "$XDG_DATA_HOME"/vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pacinst stow
pacinst openssh
pacinst man-db man-pages

### --- Install packages --- ###

### --- Main system setup --- ###

pacinst xorg-server
pacinst xorg-setxkbmap xorg-xinit xorg-xev xorg-xkill xorg-xprop xorg-xrandr xorg-xset xorg-xinit

pacinst lightdm lightdm-slick-greeter
"$XDG_BIN_DIR"/services/lightdm/init.sh

yayinst awesome-git
yayinst i3lock-fancy-git
pacinst picom
pacinst arandr

## Themes
pacinst lxappearance
yayinst gtk-theme-arc-gruvbox-git
pacinst papirus-icon-theme
pacinst qt5ct
yayinst adwaita-qt

## Fonts
pacinst noto-fonts
pacinst otf-font-awesome
yayinst nerd-fonts-complete
pacinst font-manager

## Keyboard
yayinst keyd-git
"$XDG_BIN_DIR"/services/keyd/init.sh
yayinst xkblayout-state-git

## Audio
pacinst pulseaudio  # Main package
yayinst volctl      # Volume System Tray
pacinst pulsemixer  # Pulse Audio TUI
pacinst pavucontrol # Pulse Audio Volume Control GUI
pacinst pamixer     # Pulse Audio CLI
pacinst playerctl

pacinst blueman bluez # Blueman is a GUI for bluez

pacinst network-manager-applet
pacinst gnome-keyring # Should start systemd service automatically

pacinst xfce4-power-manager
pacinst mate-system-monitor
pacinst bottom
pacinst udiskie # Automounts external drives

pacinst caja
yayinst lf
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
pacinst pandoc
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
# yayinst massren
yayinst dragon-drop
yayinst handlr-bin
pacinst neofetch
pacinst xdotool
pacinst unclutter

pacinst pass

alert "INSTALLED MAIN SYSTEM SETUP"

###############################################

### --- Programming tools --- ###
## Install system version of node
pacinst nodejs-lts-gallium
yayinst nvm
sudo npm i -g yarn
pacinst httpie
yayinst postman-bin
yayinst lazynpm
pacinst lazygit
pacinst tig
yayinst zeal # Documentation browser

pacinst github-cli

yayinst vscodium-bin

pacinst tldr
pacinst shellcheck

## LSPs
sudo npm i -g typescript typescript-language-server
pacinst lua-language-server
yayinst terraform-ls

## Formatters
sudo npm install -g @fsouza/prettierd
sudo npm install -g stylelint
pacinst stylua
pacinst shfmt
yayinst nodejs-markdownlint-cli

alert "INSTALLED PROGRAMMING TOOLS"

### --- Install Applications --- ###

yayinst safeeyes
pacinst redshift
# yayinst redshift-gtk

pacinst firefox
yayinst brave-bin
pacinst chromium

yayinst kazam
yayinst goldendict-git
yayinst skypeforlinux-stable-bin
yayinst slack-desktop
yayisnt zoom
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
