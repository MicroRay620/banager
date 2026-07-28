#!/usr/bin/env bash
# WARNING: This may change to be a plugin in the blugins repos

# shellcheck source=/dev/null
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh"
source -- "${XDG_CACHE_HOME:-$HOME/.config}/banager/config.sh"
# shellcheck disable=SC2154
if [ "$correction" = "true" ]; then 
    if [ ! -e "${XDG_CACHE_HOME:-$HOME/.config}/banager/user/fix-cmd.sh" ]; then
        touch "${XDG_CACHE_HOME:-$HOME/.config}/banager/user/fix-cmd.sh"
        echo -e "Your system has a correction tool [thefuck or pay-respect] installed.\nWould you like the alias enabled? [y/N] "
        read -er alias_prompt 
        case "$alias_prompt" in 
            y | Y | *yes* | *Yes* | *YES*) 
                alias_prompt="true" 
                echo "If you want a custom alias, please type it here. Otherwise, just press Enter" 
                read -r custom_alias
                case "$custom_alias" in 
                    "" | *" "*) custom_alias="fuck" ;;
                esac
                # shellcheck disable=SC2154
                echo -e "$bash_declare\n$bash_gen\n$dont_delete\nfix_alias=\"$custom_alias\"" >> "${XDG_CACHE_HOME:-$HOME/.config}/banager/fix-cmd.sh"
                ;;
            n | N | *no*  | *No*  | *NO* ) alias_prompt="false" ;;
        esac
        # shellcheck source=/dev/null
        source -- "${XDG_CACHE_HOME:-$HOME/.config}/banager/user/fix-cmd.sh"
        if [ "$alias_prompt" = "true" ]; then
            alias_call="--alias \"$fix_alias\""
        else
            alias_call=""
        fi
    fi
    if command -v thefuck &>/dev/null; then 
        # There will be additions made to allow you make it run without needing input
        # That will be customizable
        echo "Do you want to have thefuck run automatically? [y/N] "
        read -r autochoice
        case "$autochoice" in 
            y | Y) auto_run="-r --hard" ;;
            *) auto_run="";
        esac
        eval "$(thefuck "$auto_run $alias_call")"
    elif command -v pay-respect &>/dev/null; then 
        if [ -z "$handler" ]; then 
            echo "Would you like the [command not found] handler? [y/N] "
            read -r cnf_handler
            case "$cnf_handler" in 
                y | Y) 
                    echo "handler=true" >> "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/fix-cmd.sh" 
                    handler=true
                    ;;
                *) 
                    echo "handler=false" >> "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/fix-cmd.sh" 
                    handler=false
                    ;;
            esac
        fi
        if [ "$handler" = "true" ]; then
            handle="--nocnf"
        else 
            handle=""
        fi
        eval "$(pay-respect "$alias_call $handle")"   
    fi
fi

