#!/bin/bash
# TODO: Make a custom terminal command for banager to allow installation of and display of various things
locate_source="$XDG_DATA_HOME/banager/deps/config.sh"
locate_config="$XDG_CONFIG_HOME/banager"
export bastore="$HOME/.local/share/banager/deps"
# Will figure out how to make a proper command at a later point
alias banare='$locate_source'
configs=$(getopts -o c,h,p --long config,help,plugins --name "$0" -- "$@")
eval set -- "$configs"
banager() {
    while true; do 
        case "$1" in 
            "-c" | "--config") 
                echo "$locate_config/config.sh" 
                exit 0
                ;;
            "-h" | "--help") 
                echo "work in progress" 
                exit 0
                ;; # This will be a function
            "-p" | "--plugins") 
                echo -e "Installed plugins are:\n$(ls "$locate_config/plugins")" 
                exit 0
                ;;
        esac
    done
}
source -- "$locate_config"/config.sh

