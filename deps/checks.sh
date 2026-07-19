#!/bin/bash
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/banager"
# Commands
for cmd_file in "$data_dir"/commands/*; do
    if [ -f "$cmd_file" ]; then
        # shellcheck disable=SC1090
        source "$cmd_file"
    fi
done

# Plugins
# This is for managing the plugins
for plugin_file in "$config_dir"/plugins/*.plugin*; do
    # shellcheck disable=SC1090
    [ -f "$plugin_file" ] && source "$plugin_file"
done
