#!/bin/bash
# shellcheck disable=SC1091
source -- "$XDG_CONFIG_HOME/banager/commands/package_managers.sh"
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
# Arch specific aliases
if [[ "$PKG_MGR" = "pacman" ]]; then
    alias pacman='$SUPER pacman' # Will make a alias for every package manager
    alias pacignore='$SUPER $PKG_MGR $IGNORE'
    alias extpacinstall='$SUPER $PKG_MGR -U'

    alias aurinstall='$AUR $INSTALL'
    alias aurremove='$AUR $REMOVE'

    alias aurupdate='$AUR $UPDATE'

    if command -v downgrade &>/dev/null; then
        # For configuring, please do `$ man downgrade` or `$ downgrade --help`
        # INFO: downgrade is only on Arch
        alias downgrade='$SUPER downgrade' # This is to make using the command easier
    fi
    # To update just type in your AUR manager for this, can be done with `$ paru` or `$ yay`
    # the `else` is no longer necessary, adding pacupdate for all distros for simplicity sake 
fi
