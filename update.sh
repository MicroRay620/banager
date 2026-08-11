#!/usr/bin/env bash 
# This is a file that uses things from install.sh 
# shellcheck source=/dev/null
source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/install/update.storage.sh"
# shellcheck disable=SC2154
echo "$installed_branch"
# Uses GitHub for stability and uptime
git clone "https://github.com/MicroRay620/banager"
if [ -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/" ]; then 
    if [ -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run" ]; then 
        echo "Updating banager/run..."
        rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run"
        cp -fr --update=all ./banager/run "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
        echo "Updated banager/run"
    fi
    if [ -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src" ]; then
        echo "Updating banager/src..."
        rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src"
        cp -fr --update=all ./banager/src "${XDG_DATA_HOME:-$HOME/.local/share}/banager" 
        echo "Updated banager/src"
    fi
fi
if [ -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager" ]; then 
    echo "Updating banager command..."
    cp -fr --update=all ./banager/terminal/banager "${XDG_BIN_HOME:-$HOME/bin}/banager"
    echo "Updated banager command"
fi

