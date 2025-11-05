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

#######
# Git #
#######

alias ga="git add"                                        # Stage files for commit
alias gu="git add -u"                                     # Stage all modified and deleted files
alias gd="git diff"                                       # Show unstaged changes
alias gdc="git diff --cached"                             # Show staged changes
alias gs="git status --untracked-files=no"                # Show status without untracked files
alias gc="git checkout"                                   # Switch branches or restore files
alias gl="git log --graph --oneline --decorate"           # Show compact commit history with graph

#########
# Python/Conda #
#########

alias ca='conda activate'
alias cda='conda deactivate'

#######
# Mac #
#######

alias cc="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
