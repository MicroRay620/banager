#!/usr/bin/env bash
# TODO: Make a custom terminal command for banager to allow installation of and display of various things
locate_source="$XDG_DATA_HOME/banager/run/config.sh"
locate_config="$XDG_CONFIG_HOME/banager"
export bastore="$HOME/.local/share/banager/run"
# Will figure out how to make a proper command at a later point
alias banare='$locate_source'
configs=$(getopts -o c,h,p --long config,help,plugins --name "$0" -- "$@")
eval set -- "$configs"
for grab in curl wget; do
    if command -v "$grab"; then 
        get="$grab"
    fi
done
Banager() {
    while true; do 
        case "$1" in 
            "-c" | "--config") 
                echo "$locate_config/config.sh" 
                exit 0
                ;;
            "-h" | "--help") 
                echo "work in progress"
                exit 0
                ;; # This will be a function
            "-p" | "--plugins") 
                while true; do 
                    case "$1" in 
                        *list*) 
                            echo -e "Installed plugins are:\n$(ls "$locate_config/plugins")" 
                            shift 1
                            ;;
                        *install*) 
                            place=0
                            arg="$2"
                            if [ -z "$arg" ] || [ "${arg:0:1}" = "-" ]; then 
                                echo "Error: No plugin"
                                echo "To install plugins please do: banager -p install <RAW PLUGIN FILE URL>"
                            fi
                            for gets in curl wget; do
                                if [ "$place" = 0 ]; then 
                                    flag="-O"
                                elif [ "$place" = 1 ]; then 
                                    flag="-P"
                                else
                                    echo "No flag avaliable"
                                fi
                                if command -v "$gets" &>/dev/null && [ ! "$place" -ge 1 ]; then 
                                    $gets "$flag $arg"
                                    break
                                else 
                                    (( place += 1 ))
                                fi
                            done
                            shift 2
                            ;;
                        *remove*)
                            echo "argument is in development"
                            arg="$2"
                            # Add a for loop that will show all the possible plugins that can be removed
                            shift 2
                            ;;
                        *)
                            echo "BC1: Plugin Error 1: That flag argument doesn't exist"
                    esac
                done 
                # Probably will make more options for this
                # TODO: Make this able to install plugins and have a sub-argument
                exit 0
                ;;
            "-u" | "--update" | "update") 
                $get https://codeberg.org/RubyRose/banager/raw/branch/main/install.sh && sh install.sh && rm -rf ./install.sh 
                shift 1
                ;;
        esac
    done
}
alias banager=Banager
# shellcheck source=/dev/null
source -- "$locate_config"/config.sh

