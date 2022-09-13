
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
alias gl=" git log --name-status"

function gp() {
	# Grep with directory-scope search and colored output
	grep --color -n  -i -p $1 *
}

function gm() {
    # Commit without quotes around the message:
    #    $ gm This is commit message without wuotes
    git commit -m "$*"
}

function git-frequent() {
    # Print out the most commonly used Python methods in a repository
    git grep -i -o -w ' [a-z_0-9]\+(' . | cut -f2 -d':' | sort | uniq -c | sort -nrk1,1 | less
}


#######
# Mac #
#######

alias cc="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

# https://apple.stackexchange.com/a/33679
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx\n

function line() {
	# Print lines in file $1 between $2 and $3 
	head -n $(($2 + $3))  $1 | tail -n $3
}
