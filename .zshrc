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
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;46'

#############
## ALIASES ##
#############

alias be="bundle exec"
alias ber="bundle exec rspec"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias pyS="python -m SimpleHTTPServer 9000"
alias djS="python manage.py runserver"
alias jsS="live-server --port=9000"
alias jsB="browser-sync start --server --files \"stylesheets/*.css, scripts/*.js, *.html\""
alias rm=rm
alias brewski="brew update && brew upgrade && brew cleanup; brew cask cleanup; brew doctor"
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
# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

#update all the things
update() {
    local brew="brew update; brew upgrade --all;"
    # local gem="gem update;"
    sh -c $brew;
    # sudo sh -c $gem
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
man() {
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

# RVM and Ruby Path Logic
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#export EDITOR=vim


# NVM and Node Path Logic
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="$PATH:`yarn global bin`"

# GO Path
#export GOPATH=$HOME/workbench/go
#export GOROOT=/usr/local/opt/go/libexec
#export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$GOROOT/bin

# MY Executables
export PATH=$PATH:$HOME/.bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
#export PATH=$PATH:$HOME/.multirust/toolchains/stable/cargo/bin

export PATH=$PATH:./bin
export HOMEBREW_GITHUB_API_TOKEN=4330a63bf27a9187d9deedac8331f588587b10e3

# PYTHON3
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/Cellar/python3/3.5.1/bin/python3.5
#source /usr/local/bin/virtualenvwrapper.sh

# Anaconda
#export PATH=$HOME/anaconda/bin:$PATH

# Java
#export JAVA_HOME=$(/usr/libexec/java_home)
#source /Users/gary/.virtualenvs/py3/bin/activate.sh
#source /usr/local/bin/activate.sh
