#!/usr/bin/env bash
# This file is for all the built-in/pre-installed plugins for banager
# blesh is one of the few built-in banager plugins
# What this enabled is stuff like syntax highlighting and more 
# shellcheck source=/dev/null
source -- /etc/os-release
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/package_manager.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh"
# Because of how common it is for people to use syntax highlighting and command completion there is no option to enable or disable this
if [ "$ID" = "nixos" ] || [ "$ID_LIKE" = "nixos" ] ; then 
    # shellcheck source=/dev/null
    source -- "$(blesh-share)"/ble.sh
    echo "You're on NixOS: please add blesh to the packages installed"
elif [ "$ID" = "archlinux" ] || [ "$ID_LIKE" = "archlinux" ]; then
    if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins/archlinux.plugin.sh" ]; then
        if command -v ble-opt &>/dev/null; then 
            source /usr/share/blesh/ble.sh
        else 
            $AUR "$SKIP_CONF $INSTALL" blesh 
            source /usr/share/blesh/ble.sh
        fi
    fi
else
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    # shellcheck source=/dev/null disable=SC2154
    source -- "${XDG_DATA_HOME:-$HOME/.local/share}/blesh/ble.sh"
fi
# starship
# shellcheck disable=SC2154
if [ "$starship" = "true" ]; then 
    if command -v starship &>/dev/null; then 
        if [ ! -e "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/starship.completion.sh" ]; then 
            touch "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/starship.completion.sh"
            starship completions bash >> "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/starship.completion.sh"
            source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/starship.completion.sh"
        else 
            source -- "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user/starship.completion.sh"
        fi
        if [ ! -e "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml" ]; then
            touch "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
            starship preset bracketed-segments >> "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
            echo "To change your preset for starship, either look at the starship documentation or run \`\$ starship preset\ <PRESET OPTION> >> ~/.config/starship.toml\`"
            eval "$(starship init bash)"
        else 
            eval "$(starship init bash)"
        fi
    fi
fi
# zoxide 
# shellcheck disable=SC2154
if [ "$dirmember" = "true" ]; then
    if command -v zoxide &>/dev/null; then 
        eval "$(zoxide init bash --cmd cd)"
    else
        if [ ! "$ID" = "nixos" ] || [ ! "$ID_LIKE" = "nixos" ]; then 
            $SUPER "$PKG_MGR $INSTALL" zoxide 
        fi
        echo -e "\e[31mBC1: You have the zoxide plugin but zoxide isn't installed.\e[0m" 
    fi
fi
# command correction
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
    else 
        echo -e "REPO LINKS:\nhttps://github.com/nvbn/thefucks\nhttps://github.com/iffse/pay-respects"
        echo "Would you like thefuck or pay-respect? "
        read -r correct_option
        shopt -s nocasematch
        case "$correct_option" in 
            thefuck) $SUPER "$PKG_MGR $INSTALL" thefuck ;;
            pay-respect) 
                if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/plugins/archlinux.plugin.sh" ]; then 
                    $AUR "$INSTALL" pay-respects 
                else
                    if [ "$ID" = "nixos" ] || [ "$ID_LIKE" = "nixos" ]; then 
                        echo "Add pay-respects to your nixos configuration.nix"
                    else
                        if command -v cargo &>/dev/null; then 
                            cargo install -y pay-respects
                        fi
                    fi
                fi
        esac
    fi
fi
