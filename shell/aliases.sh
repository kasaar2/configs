###########
# General #
###########

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias l="ls -lsthr --color"
    alias la="ls -lasthr --color"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias l="ls -lsthrG"
    alias la="ls -lasthrG"
fi

alias p="pwd"
alias d="cd"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias dp="cd ~/Desktop"

alias ez="vim ~/.zshrc"
alias sz="echo 'sourcing .zshrc'; source ~/.zshrc"
alias ev="vim ~/.vimrc"
alias sv="source ~/.vimrc"

alias ip="ipython"
alias jpn="jupyter notebook"
alias ipn='ipython --no-banner -c "import numpy as np" -i'
alias ipp='ipython --no-banner -c "import numpy as np; import pandas as pd" -i'

alias v='nvim'
alias vim='nvim'

alias rg="/opt/homebrew/Cellar/ripgrep/13.0.0/bin/rg"

#######
# Git #
#######

alias ga="git add"
alias gu="git add -u"
alias gd="git diff"
alias gdc="git diff --cached"
alias gs="git status"
alias gc="git commit -v"
alias gcm="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gw="git add -u; git commit -m wip"
alias gl="git log --name-status"
alias gpl="git pull"
alias gps="git push"
alias glog="git log --graph --oneline --decorate"

#########
# Python/Conda #
#########

alias ca='conda activate'
alias cda='conda deactivate'

#######
# Mac #
#######

alias cc="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
