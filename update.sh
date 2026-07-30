#!/usr/bin/env bash 
# This is a file that uses things from install.sh 
# shellcheck source=/dev/null
source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/install/update.storage.sh"
# shellcheck disable=SC2154
echo "$installed_branch"
git clone --bare "https://codeberg.org/RubyRose/banager.git"

if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/" ]; then 
    if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run" ]; then 
        cp -fru ./banager/run "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
    fi
    if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src" ]; then 
        cp -fru ./banager/src "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
    fi
fi
if [ -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager" ]; then 
    cp -fu ./banager/terminal/banager "${XDG_BIN_HOME:-$HOME/bin}/banager"
fi
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/banager" ]; then 
    if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh" ]; then 
        cp -fu ./banager/config/config.sh "${XDG_CONFIG_HOME:-$HOME/.config}/banager"
    fi
    if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/banager/usr-alias.sh" ]; then 
        cp -fu ./banager/config/usr-alias "${XDG_CONFIG_HOME:-$HOME/.config}/banager/usr-alias.sh"
    fi
fi
