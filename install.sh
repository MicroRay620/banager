#!/usr/bin/env bash
# TODO: Make a custom terminal command for banager to allow installation of and display of various things
locate_config="$XDG_CONFIG_HOME/banager"
export bastore="$HOME/.local/share/banager/run"
# Will figure out how to make a proper command at a later point
flag_num=0
for grab in curl wget; do
    if command -v "$grab" &>/dev/null; then 
        get="$grab"
        break
    else 
        (( flag_num += 1 ))
    fi
done
if [ "$flag_num" = 0 ]; then 
    flag="-Lf --output"
elif [ "$flag_num" = 1 ]; then 
    flag="c4 --tries=3 --output-file="
fi
belp() {
    echo -e "banager [FLAG] [ARG] [URL]
    -h | --help: display this menu
    -c | --config: lists the config location for you file
    -p | --plugins: interact with plugins 
        help: list all the arguments for banager -p 
            aliased to banpelp
        list: list out the installed plugins that's in ~/.config/banager/plugins/
            aliased to banpist 
        install | add: install a new plugin (requires a url to the raw bil
            banager [-p | --plugins] [install|add] {RAW PLUGIN FILE URL}
            aliased to banpadd
        uninstall | remove | rm: remove an installed plugin 
            banager [-p | --plugins] [uninstall|remove] {PLUGIN FILE}
    -u | --update: updates banager"
}
pelp() {
    echo -e "banager [-p | --plugins] [ARG] [URL]
        help: display this menu 
        list: show all the installed plugins 
        install | add: install a new plugin 
        uninstall| remove | rm: uninstall an existing plugin"
}
Banager() {
    case "$1" in 
        "-h" | "--help") 
            belp 
            return
            ;; # This will be a function
        "-c" | "--config") 
            echo "$locate_config/config.sh"
            shift 1
            return
            ;;
        "-p" | "--plugins")
            case "$2" in 
                help) 
                    pelp 
                    shift 1R
                    return 
                    ;;
                list) 
                    echo -e "Installed plugins are:\n$(ls "$locate_config/plugins")" 
                    shift 1
                    return
                    ;;
                install | add) 
                    arg="$3"
                    if [ -z "$arg" ] || [ "${arg:0:1}" = "-" ]; then 
                        echo -e "\e[31mError: No plugin after $2\e[0m"
                        echo "To install plugins please do: \`\$ banager [-p|--plugins] [install|add] <RAW PLUGIN FILE URL>\`"
                        return
                    fi
                    file="$HOME/.config/banager/plugins/$3.plugin.sh"
                    case $3 in 
                        *.*) "$get" "$flag$file" "$arg" ;;
                        *) "$get" "$flag$file" "https://codeberg.org/RubyRose/blugins/raw/branch/main/plugins/$arg.plugin.sh" ;;
                    esac
                    shift 2
                    ;;
                uninstall | remove | rm)     
                    arg="$3"
                    if [ -e "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins/$3.plugin.sh" ]; then
                        echo "Do you want to remove $3.plugin.sh? "
                        read -r confirmation 
                        shopt -s nocasematch
                        case "$confirmation" in
                            yes)
                                echo "removing $3.plugin.sh from ~/.config/banager/plugins"
                                file="$3.plugin.sh"
                                cd "$HOME/.config/banager/plugins/" || return
                                rm -rf "$file"
                                echo "removed $3.plugin.sh from ~/.config/banager/plugins"
                                echo "removing $3.plugin.sh cache"
                                rm -rf "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugin/$3.*.sh"
                                ;;
                            no) return ;;
                        esac
                    else 
                        echo "You don't have that plugin installed. Nothing to remove"
                    fi
                    shift 2
                    ;;
                *)
                    echo "BC1: Plugin Error 1: $2 argument doesn't exist for --plugins"
                    shift 2 
                    ;;
            esac
            # Probably will make more options for this
            # TODO: Make this able to install plugins and have a sub-argument
            ;;
        "-u" | "--update" | "update") 
            $get https://codeberg.org/RubyRose/banager/raw/branch/main/update.sh && sh update.sh && rm -rf ./update.sh 
            shift 1
            ;;
    esac
}
alias banager=Banager
alias banpelp='Banager -p help'
alias banpist='Banager -p list'
alias banpadd='Banager -p add'
alias banprem='Banager -p rm'
# shellcheck source=/dev/null
source -- "$locate_config"/config.sh
