#!/usr/bin/env bash
# shellcheck source=/dev/null
if [ -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager" ]; then 
    source -- "${XDG_BIN_HOME:-$HOME/.local/bin}/banager"
elif [ -e "/usr/local/bin/banager" ]; then 
    source -- /usr/local/bin/banager 
fi
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/alias.sh"
# All of these are to abide by the XDG standard
# For more about these please go to: https://specifications.freedesktop.org/basedir/latest/
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
# NOTE: This is just making the cache directory
if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager" ]; then 
    mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager"
    if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user" ]; then 
        mkdir "${XDG_CACHE_HOME:-$HOME/.https://specifications.freedesktop.org/basedir/latest/cache}/banager/user" 
    fi
    if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins" ]; then 
        mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins"
    fi
fi

if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs" ]; then
    mkdir "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs"
fi
# OPTIM: This was originally a for loop which would slow down banager on systems with less ram 
date=$(date +"%Y.%m.%d")
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log" ]; then 
    touch "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log"
    date >> "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log"
else 
    date >> "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log"
fi
# shellcheck source=/dev/null
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/builtin.plugin.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/enviroment.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh"

# Plugins
# This is for managing the plugins
# shellcheck disable=SC2154
for plugin_file in "$config_dir"/plugins/*.plugin*; do
    plugin_path="${plugin_file##*\/}"
    invalid_plugin="${plugin_path%%.plugin.sh}"
    if [ -f "$plugin_file" ]; then
        echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is found" >> "$log_file"
        # NOTE: This is here for debugging. 
        # Uncomment this if you want to test your plugin
        # echo "Reading $invalid_plugin.plugin.sh"
        owner=$(cat "$plugin_file" | grep "# owner =")
        shebang=$(cat "$plugin_file" | grep "#!banager/plugin")
        if [ -n "$owner" ]; then
            # shellcheck source=/dev/null
            source "$plugin_file"
            echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is enabled" >> "$log_file"
            # NOTE: This is here for debugging. Uncomment this if you are debugging a plugin for Banager
            # echo -e "$invalid_plugin is valid"
            # echo -e "#!banager/plugin exists in $invalid_plugin"
        else
            echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is disabled" >> "$log_file"
            cat "$plugin_file"
            echo "$invalid_plugin is invalid"
            if [ -z "$shebang" ]; then 
                # NOTE: This checks for #!banger/plugin to see if a plugin is valid
                echo -e "\e[31m Cause: BC1: $invalid_plugin.plugin.sh's #!banager/plugin is missing\e[0m"
                echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is missing #!banager/plugin" >> "$log_file"
            fi
            if [ -z "$owner" ]; then 
                echo -e "\e[31m Cause: BC2: $invalid_plugin.plugin.sh's 'owner' field is empty\e[0m"
                echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is owner field is empty" >> "$log_file"
            else 
                echo -e "\e[31mCause: BC1: $invalid_plugin.plugin.sh's 'owner' field is missing\e[0m"
                echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is owner field is missing" >> "$log_file"
            fi
        fi
    fi
done 
