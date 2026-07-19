#!/bin/bash
source "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config"
source "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins/fetch.plugin.sh"
if [ "$flag_display" = "true" ]; then
    Flag
fi
