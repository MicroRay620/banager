#!/usr/bin/env bash
# TODO: Make a custom terminal command for banager to allow installation of and display of various things
locate_source="$XDG_DATA_HOME/banager/run/config.sh"
locate_config="$XDG_CONFIG_HOME/banager"
export bastore="$HOME/.local/share/banager/run"
# Will figure out how to make a proper command at a later point
alias banare='$locate_source'
configs=$(getopts -o c,h,p --long config,help,plugins --name "$0" -- "$@")
eval set -- "$configs"
grabs=("curl" "wget") 
for grab in "${grabs[@]}"; do
    if command -v "$grab"; then 
        get="$grab"
    fi
done
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
                # Probably will make more options for this
                # TODO: Make this able to install plugins and have a sub-argument
                # This will use the $get variable:
                # - First it will cd into $XDG_CONFIG_HOME (~/.config/banager/plugins)
                # - Then it will pull the plugin from the url
                # - Then it will exit 
                exit 0
                ;;
            "-u" | "--update" | "update") 
                $get https://codeberg.org/RubyRose/banager/raw/branch/main/install.sh && sh install.sh && rm -rf ./install.sh 
                ;;
        esac
    done
}
# shellcheck source=/dev/null
source -- "$locate_config"/config.sh

