#!/usr/bin/env bash
source -- /etc/os-release
banampt=$(mktemp -d banampt.XXXXXX)
cd "$banampt" || exit 1

# supers=$("sudo" "doas")
# for super in "${supers[@]}"; do 
#    if $super &>/dev/null; then 
#        SUPER="$super"
#        break
#    else 
#        continue
#    fi
# done
echo "Checking dependencies..."
if command -v bleopt &>/dev/null; then
    echo "ble.sh is installed, can continue"
else 
    echo "ble.sh is not installed. Please install it then try again"
    cd ../ || exit 1
    rm -rf "$banampt"
    if [ ! "$ID" = "nixos" ] && [ ! "$ID_LIKE" = "nixos" ]; then
        if [ ! "$ID" = "archlinux" ] && [ ! "$ID_LIKE" = "archlinux" ]; then 
            git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
            make -C ble.sh install PREFIX=~/.local
            echo 'source -- ~/.local/share/blesh/ble.sh' >> "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/blesh.sh"
        fi
    fi
    exit 2
fi

git clone https://codeberg.org/RubyRose/banager.git 

echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/

echo "Making the data directory..."
mkdir "${XDG_DATA_HOME:-$HOME/.local/share}/banager"
echo "Made the banager data directory :)"
echo "Making the config directory..."
mkdir "${XDG_CONFIG_HOME:-$HOME/.config}/banager"
echo "Making the plugin directory..."
mkdir "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins"
echo "Made the config directory :)"
echo "Making the cache directory..." 
mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager"
echo "Making the user cache..."
mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user"
echo "Made the user cache :)"
echo "Making the plugin cache..."
mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins"
echo "Made the cache directory."may not point to the repo root. Pr

mv -fu ./banager/run/ ./banager/commands/ "$HOME"/.local/share/banager
# echo "Install for [user] or [system]? "
# echo "On NixOS system, it's recommended to do user"
# read -r install_choice
# echo "Adding the command..."
# case "$install_choice" in 
#    *user* | *USER*) mv -fu "$banampt"/commands/banager/banager.sh "$HOME/.local/bin/" ;;
#    *sys*  | *SYS* ) $SUPER mv -fu "$banampt"/commands/banager/banager.sh /usr/local/bin ;;
# esac
# This command is temporary and will be removed once I get the installation working 
mv -fu ./banager/config/config.sh "${XDG_CONFIG_HOME:-$HOME/.config}"
if [ -e "$HOME/.bashrc" ]; then 
    mv -fu "$HOME"/.bashrc "$HOME"/.bashrc.bak
    echo "Made .bashrc.bak"
fi
touch "$HOME"/.bashrc
# The banager_config="$XDG_DATA_HOME/banager/run/" source -- "$banager_config"/config.sh is temporary until I can get $banater to work in the source
echo -e "#!/usr/bin/env bash
\nbanager_config=\"\$XDG_DATA_HOME/banager/run/\"\n
# shellcheck source=/dev/null
\nsource -- \"\$XDG_DATA_HOME/banager/run/config.sh\"" >> "$HOME"/.bashrc
cd ../ || exit 1
rm -rf "$banampt"

echo "Installed."
exit 0
