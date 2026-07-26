#!/bin/bash
# # DO NOT REMOVE THESE
# # THESE ARE TO ENSURE THE CONFIG & COMMANDS WORK
# # THEY WON'T BE NEEDED EVENTUALLY
# # variables and for loops will be removed at a later date
# config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
# data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/banager"
# shopt -s expand_aliases
# for cmd_file in "$data_dir"/commands/*; do
#     if [ -f "$cmd_file" ]; then
#         # shellcheck disable=SC1090
#         source "$cmd_file"
#     fi
# done
# # This is for managing the plugins
# for plugin_file in "$config_dir"/plugins/*.plugin*; do
#     # shellcheck disable=SC1090
#     if [ -f "$plugin_file" ]; then  
#         source "$plugin_file"
#     fi
# done
# For the variables used, `export` is needed. 
# This is to ensure they can be accessed by the local options
# export flag_display="true"
# export enable_alias="true"
# export distro_aliases="true"


# Evals and Sources 
# This is here for you imports and addition plugins that are made for bash and exclusively for banager. 
# Such as blesh, thefuck, pay-respects, starship, and zoxide
# Look at the docs for those tools for how to add them and look for the bash option.
