#!/bin/bash
shopt -s nullglob
# shellcheck disable=SC1091
source "$HOME/.local/share/banager/deps/checks.sh"
source "$HOME/.config/banager/banager.conf"
# TODO: Make these not be in the config file
if [ "$external_source" = true ]; then
    # shellcheck disable=SC1091
    source -- "$(blesh-share)"/ble.sh --attach=none
    # Uncomment which everone you want to use and have installed
    if command -v thefuck &>/dev/null; then
        eval "$(thefuck --alias -l SHELL_LOGGER)"
    elif command -v pay-respects &>/dev/null; then
        eval "$(pay-respects bash)"
    fi
    eval "$(starship init bash)"
    # TODO: Make a check and have it in the template nixos config for starship and zoxide working
    if command -v zoxide &>/dev/null; then 
        eval "$(zoxide init --cmd "cd" bash)"
    fi
fi
if [ "$flag_display" = true ]; then 
    Flag 
fi

