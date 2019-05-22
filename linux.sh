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

source scripts/nvidia-setup.sh
