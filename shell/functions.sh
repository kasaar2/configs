#!/bin/bash

# Shell functions for productivity

function gp() {
	# Grep with directory-scope search and colored output
	grep --color -n  -i -p $1 *
}

function gm() {
    # Commit without quotes around the message:
    #    $ gm This is commit message without quotes
    git commit -m "$*"
}

function git-frequent() {
    # Print out the most commonly used Python methods in a repository
    git grep -i -o -w ' [a-z_0-9]\+(' . | cut -f2 -d':' | sort | uniq -c | sort -nrk1,1 | less
}

function line() {
	# Print lines in file $1 between $2 and $3
	head -n $(($2 + $3))  $1 | tail -n $3
}

# Directory navigation using built-in directory stack
# Enable automatic directory stack management
if [[ -n "$ZSH_VERSION" ]]; then
    # Zsh: autopushd adds every cd to the directory stack
    setopt AUTO_PUSHD           # Make cd push to directory stack
    setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
    setopt PUSHD_MINUS          # Exchange + and - when used with a number
elif [[ -n "$BASH_VERSION" ]]; then
    # Bash: we need to wrap cd to use pushd
    function cd() {
        if [ "$#" -eq 0 ]; then
            builtin pushd ~ > /dev/null
        else
            builtin pushd "$@" > /dev/null
        fi
    }
fi

function dl() {
    # List the directory stack (last 20 directories)
    dirs -v | head -n 20
}

function dj() {
    # Jump to the Nth directory from the directory stack
    if [[ -z "$1" ]]; then
        echo "Usage: dj <number>"
        echo "Use 'dl' to see the directory list"
        return 1
    fi

    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: Argument must be a number"
        return 1
    fi

    # Use the built-in directory stack navigation
    if [[ -n "$ZSH_VERSION" ]]; then
        # Zsh: use cd ~N to jump to stack position N
        cd ~"$1" 2>/dev/null || {
            echo "Error: Invalid directory number. Use 'dl' to see available directories."
            return 1
        }
    elif [[ -n "$BASH_VERSION" ]]; then
        # Bash: extract directory from stack and cd to it
        local dir=$(dirs -l +"$1" 2>/dev/null)
        if [[ -n "$dir" && -d "$dir" ]]; then
            builtin cd "$dir"
        else
            echo "Error: Invalid directory number. Use 'dl' to see available directories."
            return 1
        fi
    fi
}
