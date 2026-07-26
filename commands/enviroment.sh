#!/usr/bin/env bash
# shellcheck source=/dev/null
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/commands/declare.sh"
enviroment_path="${XDG_CONFIG_HOME:-$HOME/.config}/banager/user/env.sh"
if [ ! -e "$enviroment_path" ]; then
    cd "$XDG_CONFIG_HOME"/banager/user/ || exit 1
    cd "$HOME" || return
    touch "env.sh"
    echo "What's your default text editor? "
    read -r text_editor 
    if [ "$text_editor" = "neovim" ]; then 
        text_editor="nvim"
    fi
    # shellcheck disable=SC2154
    echo -e "$bash_declare\n$bash_gen\n$dont_delete\nexport text=$text_editor" >> "$enviroment_path"
fi
# shellcheck source=/dev/null
source -- "$enviroment_path"
# Env vars 
export RUST_BACKTRACE=1
export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=2000
# shellcheck disable=SC2154
export EDITOR="$text" 
export VISUAL=""

if ! command -v nix &>/dev/null; then
    # XDG Variables
    # If you have a different location, please set them here.
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export XDG_BIN_HOME="$HOME/.local/bin"
fi
export bastore="$HOME/.local/share/banager/deps"
