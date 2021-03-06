# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

###############################
## CUSTOMIZE ALL THE THINGS ##
##############################

# Oh-My-ZSH Style Dots when autocompleting
expand-or-complete-with-dots() {      # This bunch of code displays red dots when autocompleting
  echo -n "\e[31m......\e[0m"         # a command with the tab key, "Oh-my-zsh"-style.
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Start Neofetch
# neofetch

# Color all the things
export CLICOLOR=1
export LSCOLORS='gxfxbEaEBxxEhEhBaDaCaD'
export GREP_COLOR='1;35;46'

#############
## ALIASES ##
#############

alias be="bundle exec"
alias ber="bundle exec rspec"
alias cat="ccat"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias pyS="python -m SimpleHTTPServer 9000"
alias djS="python manage.py runserver"
alias jsS="live-server --port=9000"
alias jsB="browser-sync start --server --files \"stylesheets/*.css, scripts/*.js, *.html\""
alias cm="cmatrix -s && sleep 1 && exit 1 && clear"
alias nuke="cd ~/Workbench && clear"
alias dev="nvm install && yarn && ./node_modules/.bin/gulp"


####################
## CUSTOM SCRIPTS ##
####################

# Atom.io
function a() {
  if [ $1 ]; then
    atom $1
  else
    atom .
  fi
}

# VS Code
function c() {
  if [ $1 ]; then
    code $1
  else
    code .
  fi
}

# VS Code Insiders
function ci() {
  if [ $1 ]; then
    code-insiders $1
  else
    code-insiders .
  fi
}

function rc() {
  if [ $1 ]; then
    mkdir -p "$1"

    # Scaffold component file
    echo "import React from 'react';\nimport { Styled$1 } from './$1.styled';\n" > "$1/$1.js"
    echo "const $1 = () => (<Styled$1>This is $1 Component</Styled$1>);\n\nexport default $1;" >> "$1/$1.js"

    # Scaffold test file
    touch "$1/$1.test.js"

    # Scaffold StyledComponent file
    echo "import styled from 'styled-components';\n" > "$1/$1.styled.js"
    echo "export const Styled$1 = styled.div\`\n  background-color:green\n\`;" >> "$1/$1.styled.js"

    # Scaffold Interface file
    echo "import $1 from './$1';\n\nexport default $1;" > "$1/index.js"
  else
    echo "Please provide a component name"
  fi
}

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

#update all the things
function bump() {
  echo "Updating packages..."
  if [[ "$(uname)" == "Darwin" ]]; then
    brewu && brewc; brew doctor
  elif [[ "$(uname)" == "Linux" ]]; then
    sudo apt update && sudo apt upgrade -y
  else
    echo "This is not a supported OS."
  fi
}

#change to current Finder directory
# cdf() {
#     target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
#     if [ "$target" != "" ]; then
#         cd "$target"; pwd
#     else
#         echo 'No Finder window found' >&2
#     fi
# }

#color dem man pages
function man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


###############
## ENV Paths ##
###############

# YARN
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# MY Executables
export PATH=$PATH:$HOME/.bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

# Deno
export PATH="/Users/ggrumbley/.deno/bin:$PATH"

export NVM_DIR="/Users/garygrumbley/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
