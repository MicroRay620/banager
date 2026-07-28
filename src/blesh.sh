#!/usr/bin/env bash
# blesh is one of the few built-in banager plugins
# What this enabled is stuff like syntax highlighting and more 
# shellcheck source=/dev/null
source -- /etc/os-release
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/commands/declare.sh"
if [ "$ID" = "nixos" ] || [ "$ID_LIKE" = "nixos" ] ; then 
    # shellcheck source=/dev/null
    source -- "$(blesh-share)"/ble.sh
# TODO: Add the Arch Linux option
else 
    # shellcheck source=/dev/null disable=SC2154
    source -- "${XDG_DATA_HOME:-$HOME/.local/share}/blesh/ble.sh"
fi
