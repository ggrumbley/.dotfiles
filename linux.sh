#!/usr/bin/env bash

# Exist if any command returns with non-zero exit status fail.
set -e

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Update dotfiles..."
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

function header() {
  printf "\n======================================================================\n"
  printf "$1"
  printf "\n======================================================================\n"
}

# isCommand(command):
#   returns 0 if command is not in path, 1 otherwise.
#   Does not recongnize bash aliases

function isCommand() {
  echo "Checking for \"$1\"..."
  hash "$1" 2>/dev/null || command -v "$1"
}

if hash sudo 2>/dev/null;
then
  echo "SUDO is installed. Continuing..."
else
  echo "SUDO is not installed. Install SUDO and re-run script."
  exit 1
fi

header "Update and Upgrade the system"
sudo apt update
sudo apt upgrade -y

header "Install dev dependencies"
sudo apt install -y \
  build-essential \
  apt-transport-https \
  curl \
  fonts-hack-ttf \
  git \
  git-extras \
  lshw \
  openssl \
  terminator \
  tree \
  zsh


header "Install Prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Change shell to ZSH
if [ "$SHELL" == "/bin/bash" ]; then
  header "Change Shell to ZSH"
  chsh -s "$(which zsh)"
fi

header "Install NVM"
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh

zsh install_nvm.sh
source ~/.zprofile

nvm install lts/dubnium

header "Install Yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn
yarn --version

header "Symlink all the THINGS!"
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.npmrc" ~
ln -sfv "$DOTFILES_DIR/.zpreztorc" ~
ln -sfv "$DOTFILES_DIR/.zprofile" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/prompt_gary_setup" ~/.zprezto/modules/prompt/functions

header "Copy all the THINGS!"
cp -r "$DOTFILES_DIR/configFolders/." "$HOME"
cp -r "$DOTFILES_DIR/assets/." "$HOME/Pictures"

header "Add GNOME Themes"
if hash gsettings 2>/dev/null; then
  echo "Gnome Tweak Tool not installed"
else
  sudo apt-get install gnome-shell-extensions
  gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"
  gsettings set org.gnome.desktop.wm.preferences theme "Sweet-Dark"
  gsettings set org.gnome.desktop.interface gtk-theme "Sweet-Dark"
  gsettings set org.gnome.desktop.interface icon-theme "Sweet-Purple-Filled"
  gsettings set org.gnome.desktop.screensaver picture-uri "$HOME/Pictures/outrun_sunset.jpg"
  gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/smallMemory_mikael_gustafsson.png"
fi

source scripts/nvidia-setup.sh
