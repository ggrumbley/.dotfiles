#!/usr/bin/env bash

# Install Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Change shell to ZSH
chsh -s /bin/zsh

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Symlink all the THINGS!
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/.gemrc" ~
# ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.npmrc" ~
ln -sfv "$DOTFILES_DIR/.zpreztorc" ~
ln -sfv "$DOTFILES_DIR/.zprofile" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/prompt_gary_setup" ~/.zprezto/modules/prompt/functions
ln -sfv "$DOTFILES_DIR/.zshrc" ~

mkdir -p "~/.config/fish/functions"
cp "$DOTFILES_DIR/fish_promp.fish" ~/.config/fish/functions


ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
if [ -f "$DOTFILES_DIR/install/osx.sh" ]; then
  . "$DOTFILES_DIR/install/osx.sh"
fi

# Make .vim directories
mkdir -p ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo;

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";

#Install Must-have Brew Recipes
brew install curl;
brew install git;
brew install nvm;
brew install yarn;
brew install gpg;
brew install tree;
brew install vim;
brew install wget;

#Install fun packages
brew install ccat;
brew install cmatrix;
brew install sl;
brew install neofetch

#Install Must-have Casks
brew cask install iterm2;
brew cask install spotify;
brew cask install postman;
brew cask install notable;
brew cask install typora;
brew cask install rocket;
brew cask install vlc;
brew cask install imageoptim;
brew cask install google-backup-and-sync;
brew cask install advancedrestclient;


# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;

# Gruvbox Terminal Colors
git clone https://github.com/flipxfx/gruvbox-terminal.git ~/.vim;

# Hack Font
git clone https://github.com/chrissimpkins/Hack.git ~/.vim;

# RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3;

\curl -sSL https://get.rvm.io | bash -s stable;
