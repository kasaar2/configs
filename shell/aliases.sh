###########
# General #
###########

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias l="ls -lsthr --color"
    alias la="ls -lasthr --color"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias l="ls -lsthrG"
    alias la="ls -lasthrG"
    alias cc="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
fi

alias p="pwd"
alias d="cd"
alias u="cd .."
alias dp="cd ~/Desktop"

alias ez="vim ~/.zshrc"
alias sz="echo 'Sourcing .zshrc'; source ~/.zshrc"
alias ev="vim ~/.vimrc"

alias ip="ipython"
alias jpn="jupyter notebook"
alias ipn='ipython --no-banner -c "import numpy as np" -i'
alias ipp='ipython --no-banner -c "import numpy as np; import pandas as pd" -i'

#######
# Git #
#######

alias ga="git add"                                        # Stage files for commit
alias gau="git add -u"                                    # Stage all modified and deleted files
alias gch="git checkout"                                  # Switch branches or restore files
alias gchm="git checkout main"                            # Switch branch to main
alias gco="git commit" 
alias gcoa="git commit --amend" 
alias gd="git diff"                                       # Show unstaged changes
alias gdc="git diff --cached"                             # Show staged changes
alias gf="git fetch" 
alias gl="git --no-pager log --oneline -n 5"              # Show compact commit history
alias glo="git log --oneline"                             # Show compact commit history
alias glg="git log --graph --oneline --decorate"          # Show compact commit history with graph
alias glp='git log --pretty=format:"%C(yellow)%h%Creset %C(cyan)%ce%Creset %C(green)%d%Creset%n%C(white)%s%Creset%n"'
alias gpl="git pull" 
alias gps="git push" 
alias gst="git status --untracked-files=no"                # Show status without untracked files
alias gstu="git status"                                    # Show status with untracked files
alias gsh="git show"                                # Show HEAD
alias gshh="git show HEAD"                                # Show HEAD


################
# Python/Conda #
################

alias cac='conda activate'
alias cda='conda deactivate'

