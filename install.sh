#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ${homedir}/dotfiles
# And also installs Homebrew Packages
# And sets Sublime preferences
############################

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

homedir=$1

# dotfiles directory
dotfiledir="${homedir}/dotfiles"

# list of files/folders to symlink in ${homedir}
files="bash_profile bashrc bash_prompt aliases vimrc inputrc config/kitty/kitty.conf config/ranger/rc.conf config/ranger/rifle.conf config/ranger/scope.sh config/skhd/skhdrc config/spacebar/spacebarrc config/yabai/yabairc"

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd "${dotfiledir}" || exit
echo "...done"

# create symlinks (will overwrite old dotfiles)
for file in ${files}; do
    echo "Creating symlink to $file in home directory."
    ln -sf "${dotfiledir}/.${file}" "${homedir}/.${file}"
done

# create symlinks for bin
for file in "$dotfiledir"/bin/*; do
  filename=$(basename "$file")
  echo "Creating symlink to $filename in ~/bin."
  ln -sf "${dotfiledir}/bin/${filename}" "${homedir}/bin/${filename}"
done

# Download Git Auto-Completion
curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > ${homedir}/.git-completion.bash

# Install Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# Download HomeBrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# brew analytics off

# # Run the Homebrew Script
# ./brew.sh

if [[ "$(uname)" == "Darwin" ]]; then 
  echo "Setting MacOS defaults"
# Set MacOS Settings
 ./macos.sh
fi
