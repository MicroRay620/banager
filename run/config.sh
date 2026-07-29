#!/usr/bin/env bash
# shellcheck source=/dev/null 
source -- "${XDG_BIN_HOME:-$HOME/.local/bin}/banager"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh"
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
for cmd_file in "$data_dir"/src/*; do
    # echo "$cmd_file"
    if [ -f "$cmd_file" ]; then
        # NOTE: declare.sh is only for plugins and some files 
        # It isn't needed to be sourced
        if [ ! "$cmd_file" = "${XDG_DATA_HOME:-$HOME/.local/share}/banager/commands/declare.sh" ]; then
            # shellcheck source=/dev/null
            source "$cmd_file"
        else 
            continue 
        fi
   fi
done
# Plugins
# This is for managing the plugins
# shellcheck disable=SC2154
for plugin_file in "$config_dir"/plugins/*.plugin*; do
    plugin_path="${plugin_file##*\/}"
    invalid_plugin="${plugin_path%%.plugin.sh}"
    if [ -f "$plugin_file" ]; then 
        # NOTE: This is here for debugging. 
        # Uncomment this if you want to test your plugin
        # echo "Reading $invalid_plugin.plugin.sh"
        owner=$(cat "$plugin_file" | grep "# owner =")
        shebang=$(cat "$plugin_file" | grep "#!banager/plugin")
        if [ -n "$owner" ]; then
            # shellcheck source=/dev/null
            source "$plugin_file"
            # NOTE: This is here for debugging. Uncomment this if you are debugging a plugin for Banager
            # echo -e "$invalid_plugin is valid"
            # echo -e "#!banager/plugin exists in $invalid_plugin"
        else
            cat "$plugin_file"
            echo "$invalid_plugin is invalid"
            if [ -z "$shebang" ]; then 
                # NOTE: This checks for #!banger/plugin to see if a plugin is valid
                echo -e "\e[31m Cause: BC1: $invalid_plugin.plugin.sh's #!banager/plugin is missing\e[0m"
            fi
            if [ -z "$owner" ]; then 
                echo -e "\e[31m Cause: BC2: $invalid_plugin.plugin.sh's 'owner' field is empty\e[0m"
            else 
                echo -e "\e[31mCause: BC1: $invalid_plugin.plugin.sh's 'owner' field is missing\e[0m"
            fi
        fi
    fi
done 
if [ -f "$config_dir/plugins/gtrash.plugin.sh" ]; then 
    touch "$cache_dir/gtrash.sh" 
    if command -v gtrash &>/dev/null; then 
        gtrash completion bash >> "$cache_dir/gtrash.sh"
    fi
fi
if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/plugins/fetch.plugin.sh" ]; then 
    source -- "$config_dir/fletch.plugin.sh"
    if [ "$display_flag" = "true" ]; then
        Flag
    fi
fi
