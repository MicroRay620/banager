#!/usr/bin/env bash
# shellcheck source=/dev/null
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh"
source /etc/os-release
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/banager"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/banager"
if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user" ]; then
    mkdir "$cache_dir/user"
fi 

# Commands
for cmd_file in "$data_dir"/commands/*; do
    if [ -f "$cmd_file" ]; then
        # NOTE: declare.sh is only for plugins and some files 
        # It isn't needed to be sourced
        if [ ! "$cmd_file" = "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh" ]; then
            # shellcheck source=/dev/null
            source "$cmd_file"
        else 
            continue 
        fi
   fi
done
# Plugins
for plugin_file in "$config_dir"/plugins/*.plugin*; do
    plugin_path="${plugin_file##*\/}"
    invalid_plugin="${plugin_path%%.plugin.sh}"
    if [ -f "$plugin_file" ]; then 
        # NOTE: This is here for debugging. 
        # Uncomment this if you want to test your plugin
        # echo "Reading $invalid_plugin.plugin.sh"
        owner=$(cat "$plugin_file" | grep "# owner =")
        plugin_shebang=$(cat "$plugin_file" | grep "#!banager/plugin")
        if [ -n "$owner" ]; then
            # shellcheck source=/dev/null
            source "$plugin_file"
            # NOTE: This is here for debugging. Uncomment this if you are debugging a plugin for Banager
            # echo -e "$invalid_plugin is valid"
            # echo -e "#!banager/plugin exists in $invalid_plugin"
        else
            cat "$plugin_file"
            echo "$invalid_plugin is invalid"
            if [ -z "$plugin_shebang" ]; then 
                # NOTE: This checks for #!banger/plugin to see if a plugin is valid
                echo -e "\e[31m Cause: BC1: $invalid_plugin.plugin.sh's plugin shebang ('#!banager/plugin') is missing\e[0m"
            fi
            if [ -z "$owner" ]; then 
                echo -e "\e[31m Cause: BC2: $invalid_plugin.plugin.sh's 'owner' field is empty\e[0m"
            else 
                echo -e "\e[31mCause: BC1: $invalid_plugin.plugin.sh's 'owner' field is missing\e[0m"
            fi
        fi
    fi
done
for cache_file in "$cache_dir"/*.sh; do 
    if [ -f "$cache_file" ]; then 
        source "$cache_dir"
    else 
        continue
    fi
done
