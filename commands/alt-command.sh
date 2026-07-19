#!/bin/bash
# These are for the $HOME/.bashrc file. You can mess with this but I do not recommend it.
# Root command check
# These just are here for making your system easier
if command -v sudo &>/dev/null; then
    export SUPER="sudo"
elif command -v sudo-rs &>/dev/null; then
    export SUPER="sudo-rs"
else
    export SUPER="doas"
fi
# Command Checks
# These are here so when you copy commands, they'll use your preferred method.
# This is just to make stuff WAY more convient for you to use
# rg, rga, and grep will search an output for the paramater you put in 
# Example: typing in `$ man bash | rga help` will search all of the man page for bash and give every part with an instance of help inside of it 
if command -v rg &>/dev/null; then
    export GREP="rg"
elif command -v rga &>/dev/null; then
    export GREP="rga"
else
    export GREP="grep"
fi

# These are to make it easier to display the size of directories
if command -v dust &>/dev/null; then
    export DU="dust"
else
    export DU="du -sh"
fi

# These are to make it easier to find files
if command -v fd &>/dev/null; then
    export FIND="fd -tf -tl --show-errors --hidden --prune --exclude '.git node_modules'"
else
    export FIND="find -L"
fi

if command -v bat &>/dev/null; then
    # For what you can do, run `$ man bat`
    export CAT="bat"
elif command -v cat &>/dev/null; then
    # For what you can do, run `$ man cat`
    export CAT="cat"
else
    # TODO: Make the error red with an error code 
    echo "Install cat or bat"
fi

if command -v eza &>/dev/null; then
    export eza=true
    # For what this means: run `$ man eza` in your terminal
    export LS="eza -Gumn --all --no-permissions --no-quotes --icons=always --group-directories-first"
    # TODO: Add documentation for what $export LS does
else
    export eza=false
    # For what these mean: run `$ man ls` in your terminal
    export LS="ls -ChRskNp --all --time=access"
fi

