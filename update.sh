#!/usr/bin/env bash 
# This is a file that uses things from install.sh 
# shellcheck source=/dev/null
source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/install/update.storage.sh"
# shellcheck disable=SC2154
echo "$installed_branch"
# Uses GitHub for stability and uptime
git clone "https://github.com/MicroRay620/banager"
if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/" ]; then 
    if [ -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run" ]; then 
        rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run"
        cp -fr --update=all ./banager/run "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
    fi
    if [ -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src" ]; then
        rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src"
        cp -fr --update=all ./banager/src "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
    fi
fi
if [ -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager" ]; then 
    cp -fr --update=all ./banager/terminal/banager "${XDG_BIN_HOME:-$HOME/bin}/banager"
fi

