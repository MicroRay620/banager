#!/usr/bin/env bash
# shellcheck disable=SC2154 source=/dev/null
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config"
echo -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/enviroment.sh: loaded config file" >> "$log_file"
if command -v "$text" &>/dev/null; then 
    echo -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/enviroment.sh: config: text variable is valid editor" >> "$log_file"
else
    echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/enviroment.sh: config: Error BC3.2: text variable is invalid" >> "$log_file"
    exit 3
fi
export RUST_BACKTRACE=1
export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=2000
export EDITOR="$text" 
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
