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

# Color all the things
export CLICOLOR=1
export LSCOLORS='gxfxbEaEBxxEhEhBaDaCaD'
export GREP_COLOR='1;35;46'

#############
## ALIASES ##
#############

alias rm=rm
alias be="bundle exec"
alias ber="bundle exec rspec"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias pyS="python -m SimpleHTTPServer 9000"
alias djS="python manage.py runserver"
alias jsS="live-server --port=9000"
alias jsB="browser-sync start --server --files \"stylesheets/*.css, scripts/*.js, *.html\""
alias cm="cmatrix -s && sleep 1 && exit 1 && clear"

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
    brew update && brew upgrade && brew cleanup; brew doctor
  elif [[ "$(uname)" == "Linux" ]]; then
    sudo apt update && sudo apt upgrade -y
  else
    echo "This is not a supported OS."
  fi
}

#change to current Finder directory
cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

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

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# YARN
# export PATH="$(yarn global bin):$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# RVM and Ruby Path Logic
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#export EDITOR=vim

# MY Executables
export PATH=$PATH:$HOME/.bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

# Deno
export PATH="/Users/ggrumbley/.deno/bin:$PATH"

# Anaconda
export PATH=$HOME/anaconda/bin:$PATH

# Java
# JAVA_VERSION=1.8
# export JAVA_HOME="$(/usr/libexec/java_home -v $JAVA_VERSION)"

alias start-ems="JAVA_OPTS=\"-server -Xms256m -Xmx2g -XX:NewRatio=3 -Xss16m -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:ConcGCThreads=4 -XX:ReservedCodeCacheSize=256m -XX:+AlwaysPreTouch -XX:+TieredCompilation -XX:+UseCompressedOops -XX:SoftRefLRUPolicyMSPerMB=50 -Dsun.io.useCanonCaches=false -Djava.net.preferIPv4Stack=true -ea\" ~/dev/apache-tomcat-7.0.37/bin/startup.sh"

