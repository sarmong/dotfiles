#!/bin/bash

# Install Brew Packages

# basic
brew install node
brew install cask
brew install coreutils
brew install python
brew install git
brew install bash-completion@2
brew install neofetch
brew install bash
echo /usr/local/bin/bash|sudo tee -a /etc/shells;chsh -s /usr/local/bin/bash # this changes the default shell to the latest version of bash

brew tap zegervdv/zathura
brew install zathura
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

# cli utils
brew install tree
brew install exiftool
brew install ffmpeg
brew install imagemagick
brew install speedtest-cli
brew install youtube-dl
npm install -g trash-cli

# terminal-based apps
brew install bitwarden-cli
brew install cmus
pip3 install cmus-osx
touch ~/.config/cmus/rc
cmus-osx install
brew install joplin
brew install htop  # show processes
brew install neovim
brew install ranger

# other
brew install coreutils
brew install inetutils

# taps
brew install mongodb/brew/mongodb-community
brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai
brew install somdoron/formulae/spacebar
brew services start spacebar

# Install MacOS Applications
brew cask install eloston-chromium  # ungoogled-chromium
brew cask install brave-browser
brew cask install firefox
brew cask install thunderbird

brew cask install bitwarden
brew cask install gramps
brew cask install libreoffice
brew cask install mongodb
brew cask install stretchly

brew cask install joplin
brew cask install notion

brew cask install sublime-text
brew cask install vscodium
brew cask install iterm2

brew cask install djview
brew cask install virtualbox
brew cask install gimp
brew cask install vlc
brew cask install musescore
brew cask install vienna

brew cask install ueli
brew cask install apple-juice
