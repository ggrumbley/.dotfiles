#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Symlink all the THINGS!
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.zpreztorc" ~
ln -sfv "$DOTFILES_DIR/.zprofile" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/prompt_gary_setup" ~/.zprezto/modules/prompt/functions

if [ "$(uname)" == "Darwin" ]; then
  ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
  if [ -f "$DOTFILES_DIR/install/osx.sh" ]; then
    . "$DOTFILES_DIR/install/osx.sh"
  fi
fi

# Install extra stuff
if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
  . "$EXTRA_DIR/install.sh"
fi

# Make .vim directories
mkdir -p ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo;
