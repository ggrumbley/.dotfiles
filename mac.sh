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
brew install python3;
brew install pipenv;

#Install fun packages
brew install ccat;
brew install cmatrix;
brew install sl;
brew install neofetch;

#Install Must-have Casks
brew install --cask iterm2;
brew install --cask visual-studio-code;
brew install --cask firefox;
brew install --cask spotify;
brew install --cask slack;
brew install --cask notable;
brew install --cask typora;
brew install --cask rocket;
brew install --cask vlc;
brew install --cask imageoptim;
brew install --cask google-backup-and-sync;
brew install --cask advancedrestclient;


# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;

# Gruvbox Terminal Colors
git clone https://github.com/flipxfx/gruvbox-terminal.git ~/.vim;

# Hack Font
git clone https://github.com/chrissimpkins/Hack.git ~/.vim;
