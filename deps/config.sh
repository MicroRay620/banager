#!/usr/bin/env bash
# config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/banager"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/banager"
if [ ! -e "${XDG_CONFIG_HOME:-$HOME/.config}/banager/user" ]; then
    mkdir "$config_dir/user"
fi 
if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager" ]; then 
    mkdir "$cache_dir"
fi
# Commands
shopt -s expand_aliases
for cmd_file in "$data_dir"/commands/*; do
    if [ -f "$cmd_file" ]; then
        # shellcheck source=/dev/null
        source "$cmd_file"
    fi
done
# Plugins
# This is for managing the plugins
for plugin_file in "$config_dir"/plugins/*.plugin*; do
    plugin_path="${plugin_file##*\/}"
    invalid_plugin="${plugin_path%%.plugin.sh}"
    if [ -f "$plugin_file" ]; then 
        # NOTE: This is here for debugging. 
        # Uncomment this if you want to test your plugin
        # echo "Reading $invalid_plugin.plugin.sh"
        owner=$(grep "owner =" "$plugin_file" | cut -d'=' -f2-)
        shebang=$(grep "#!banager/plugin" "$plugin_file")
        if [ -n "$owner" ]; then
            # shellcheck source=/dev/null
            source "$plugin_file"
            # NOTE: This is here for debugging. Uncomment this if you are debugging a plugin for Banager
            # echo -e "$invalid_plugin is valid"
            # echo -e "#!banager/plugin exists in $invalid_plugin"
        else
            echo "$invalid_plugin is invalid"
            if [ -z "$shebang" ]; then 
                # NOTE: This checks for #!banger/plugin to see if a plugin is valid
                echo -e " \e[31m Cause: BC1: $invalid_plugin.plugin.sh's #!banager/plugin is missing\e[0m"
            fi
            if [ -z "$owner" ]; then 
                echo -e " \e[31m Cause: BC2: $invalid_plugin.plugin.sh's 'owner' field is empty\e[0m"
            else 
                echo -e " \e[31mCause: BC1: $invalid_plugin.plugin.sh's 'owner' field is missing\e[0m"
            fi
        fi
    fi
done
if [ -f "$config_dir/plugins/fetch.plugin.sh" ]; then 
    Flag
fi
