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

# Directory history tracking
export DIR_HISTORY_FILE="${HOME}/.dir_history"
export DIR_HISTORY_MAX=100

# Initialize directory history file if it doesn't exist
if [[ ! -f "$DIR_HISTORY_FILE" ]]; then
    touch "$DIR_HISTORY_FILE"
fi

# Track directory changes
function _track_dir() {
    local current_dir="$PWD"

    # Only track if we're in a different directory than the last entry
    if [[ -f "$DIR_HISTORY_FILE" ]]; then
        local last_dir=$(tail -n 1 "$DIR_HISTORY_FILE" 2>/dev/null)
        if [[ "$current_dir" == "$last_dir" ]]; then
            return
        fi
    fi

    # Append current directory to history
    echo "$current_dir" >> "$DIR_HISTORY_FILE"

    # Keep only last MAX entries
    if [[ $(wc -l < "$DIR_HISTORY_FILE") -gt $DIR_HISTORY_MAX ]]; then
        tail -n $DIR_HISTORY_MAX "$DIR_HISTORY_FILE" > "${DIR_HISTORY_FILE}.tmp"
        mv "${DIR_HISTORY_FILE}.tmp" "$DIR_HISTORY_FILE"
    fi
}

# Hook into directory changes
if [[ -n "$ZSH_VERSION" ]]; then
    # Zsh hook
    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd _track_dir
elif [[ -n "$BASH_VERSION" ]]; then
    # Bash hook
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }_track_dir"
fi

function dl() {
    # List the last 20 visited directories
    if [[ ! -f "$DIR_HISTORY_FILE" ]] || [[ ! -s "$DIR_HISTORY_FILE" ]]; then
        echo "No directory history yet."
        return 1
    fi

    # Show last 20 directories with line numbers (in reverse order, most recent first)
    tail -n 20 "$DIR_HISTORY_FILE" | nl -n rn -w 3 -s '. ' | tac
}

function dj() {
    # Jump to the Nth directory from the directory list
    if [[ -z "$1" ]]; then
        echo "Usage: dj <number>"
        echo "Use 'dl' to see the directory list"
        return 1
    fi

    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: Argument must be a number"
        return 1
    fi

    if [[ ! -f "$DIR_HISTORY_FILE" ]] || [[ ! -s "$DIR_HISTORY_FILE" ]]; then
        echo "No directory history yet."
        return 1
    fi

    # Get the directory at position N (counting from the end, most recent = 1)
    local dir=$(tail -n 20 "$DIR_HISTORY_FILE" | tail -n "$1" | head -n 1)

    if [[ -z "$dir" ]]; then
        echo "Error: Invalid directory number. Use 'dl' to see available directories."
        return 1
    fi

    if [[ ! -d "$dir" ]]; then
        echo "Error: Directory no longer exists: $dir"
        return 1
    fi

    cd "$dir"
}
