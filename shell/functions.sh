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
