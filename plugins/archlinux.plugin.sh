#!/bin/bash
# shellcheck disable=SC1091
source -- "$XDG_DATA_HOME/banager/commands/package_managers.sh"
source -- "$XDG_CONFIG_HOME/banager/config"
aur=( "yay" "paru" )
# shellcheck disable=SC2154
if [[ "$PKG_MGR" = "${managers[3]}" ]]; then 
    for item in "${aur[@]}"; do 
        if command -v "$item" &>/dev/null; then
            export AUR="$item"
        else 
            continue
        fi
    done 
fi
