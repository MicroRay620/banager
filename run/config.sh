#!/usr/bin/env bash
# shellcheck disable=SC2154 source=/dev/null
# NOTE: These are ble.sh configuration stuff 
shopt -u no_empty_cmd_completion
# NOTE: This is just making the cache directory
date=$(date +"%Y.%m.%d")
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log" ]; then 
    touch "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log"
    date +"%T">> "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs/banager-$date.log"
fi
# This just checks for command level
if [ -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager" ]; then 
    source -- "${XDG_BIN_HOME:-$HOME/.local/bin}/banager"
    echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: ${XDG_BIN_HOME:-$HOME/.local/bin} banager command installed at user level" >> "$log_file"
elif [ -e "/usr/local/bin/banager" ]; then 
    source -- "/usr/local/bin/banager"
    echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: /usr/local/bin/banager: banager command installed at system level" >> "$log_file"
else 
    echo -e "\e[31mBC1 Error: banager command is missing\e[0m"
    echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share/}/banager/run/config.sh: Error BC1: banager command not installed\e[0m"
    exit 1
fi
# These are the sources that get called that banager needs to use 
# The order that is used is 
# → /etc/os-release # NOTE: Don't access any of the other files /etc/
# → /usr/local/bin
# → ~/.local
#   → /bin 
#   → /state/banager 
#   → /share/banager
#       → /log
#       → /run 
#       → /src 
# → ~/.cache/banager 
#   → /user 
#   → /plugins 
# → ~/.config/banager 
#   → /plugins
#   → /config (FILE)
# Each file sourced should be listed in alphabetical order 
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/enviroment.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/builtin.plugin.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh"
# This is making the cache file for the log storage 
# Currently this doesn't work and is work in progress
if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/log.storage.time.sh" ]; then
    echo "How long would you like to store the logs? (time in terms of days) "
    read -r log_store 
    echo -e "$bash_declare\n$bash_gen\n$dont_delete\nlog_store=$log_store" >> "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/log.storage.time.sh" 
    source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/log.storage.time.sh"
    echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: log storage cache file not found: created log storage" >> "$log_file"
else
    echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: log storage cache file found" >> "$log_file"
    source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/log.storage.time.sh"
fi
if shellcheck -x "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config" &>/dev/null; then
    echo -e "\e[31mERROR BC3.1: config file failed shellcheck\e[0m"
    echo -e "\e[31m${XDG_CONFIG_HOME:-$HOME/.config}/banager/config: Error BC3: failed config file: failed shellcheck\e[0m" >> "$log_file"
else
    find lost 
    # TODO: Add the log integration
fi
# TODO: Make the log deletion logic
source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/log.storage.time.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config"

# NOTE: Doing a slower method for readability
if [ ! -e "${XDG_DATA_HOME:-HOME/.local/share}/banager/logs" ]; then 
    mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/banager/logs" 
fi
if [ ! -e "${XDG_STATE_HOME:-$HOME/.local/state}/banager" ]; then 
    mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/banager"
fi
if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager" ]; then 
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user" "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins"
fi

# Plugins
# This is for managing the plugins
for plugin_file in "${XDG_CONFIG_HOME:-$HOME/.config}/banager"/plugins/*.plugin*; do
    plugin_path="${plugin_file##*\/}"
    invalid_plugin="${plugin_path%%.plugin.sh}"
    if [ -f "$plugin_file" ]; then
        echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: $plugin_file is found" >> "$log_file"
        # NOTE: This is here for debugging. 
        # Uncomment this if you want to test your plugin
        # echo "Reading $invalid_plugin.plugin.sh"
        plugin=$(<"$plugin_file")
        shebang=$(echo "$plugin" | grep "#!banager/plugin")
        owner=$(echo "$plugin" | grep "# owner = ")
        if [[ "$plugin" =~ "#!banager/plugin" ]] && [[ "$plugin" =~ "# owner = " ]]; then
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
                echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: Error BC1: $plugin_file is missing #!banager/plugin\e[0m" >> "$log_file"
            fi
            if [ -z "$owner" ]; then 
                echo -e "\e[31m Cause: BC2: $invalid_plugin.plugin.sh's 'owner' field is empty\e[0m"
                echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: Error BC2: $plugin_file is owner field is empty\e[0m" >> "$log_file"
            else 
                echo -e "\e[31mCause: BC1: $invalid_plugin.plugin.sh's 'owner' field is missing\e[0m"
                echo  -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/run/config.sh: Error BC1: $plugin_file is owner field is missing\e[0m" >> "$log_file"
            fi
        fi
    fi
done
