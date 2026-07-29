#!/usr/bin/env bash
# shellcheck source=/dev/null
source -- /etc/os-release
banampt=$(mktemp -d banampt.XXXXXX)
cd "$banampt" || exit 1

supers=$("sudo" "doas")
for super in "${supers[@]}"; do 
   if $super &>/dev/null; then 
       SUPER="$super"
       break
   else 
       continue
   fi
done
echo "Checking dependencies..."
if command -v ble-attach &>/dev/null; then
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
# TODO: Add an input for the branch
# Branch Options:
# - stable (this will be just banager)
# - unstable (in Arch this will be banager-git
echo "Do you want [stable] or [unstable]? "
read -r branch 
case "$branch" in 
    *unstable* | *UNSTABLE*) git clone --bare https://codeberg.org/RubyRose/banager.git ;;
    *stable* | *STABLE*) git clone --bare https://codeberg.org/RubyRose/banager/src/stable.git ;;
esac
echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/

if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/banager" ]; then 
    echo "Making the data directory..."
    mkdir "${XDG_DATA_HOME:-$HOME/.local/share}/banager"
    echo "Made the banager data directory :)"
    echo "Moving the data files..."
    mv -fu ./banager/run/ ./banager/src/ "${XDG_DATA_HOME:-$HOME/.local/share}/banager"
    echo "Moved data files"
fi
if [ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/banager" ]; then 
    echo "Making the config directory..."
    mkdir "${XDG_CONFIG_HOME:-$HOME/.config}/banager"
    if [ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins" ]; then
        echo "Making the plugin directory..."
        mkdir "${XDG_CONFIG_HOME:-$HOME/.config}/banager/plugins"
        echo "Made the plugin directory :)"
    fi
    echo "Made the config directory :)"
fi
if [ ! -f "${XDG_CACHE_HOME:-$HOME/.cache}/banager" ]; then 
    echo "Making the cache directory..." 
    mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager"
    if [ ! -f "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user" ]; then
        echo "Making the user cache..."
        mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager/user"
        echo "Made the user cache :)"
    fi
    if [ ! -f "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins" ]; then 
        echo "Making the plugin cache..."
        mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/banager/plugins"
        echo "Made the plugin cache :)"
    fi
    echo "Made the cache directory."
fi
echo "Install for [user] or [system]? "
echo "On NixOS system, it's recommended to do user"
read -r install_choice
echo "Adding the command..."
case "$install_choice" in 
    *user* | *USER*) 
        if [ ! -e "${XDG_BIN_HOME:-$HOME/.local/bin}/banager.sh" ]; then 
            echo "Adding command to user..."
            mv -fu "$banampt"/src/banager/banager.sh "${XDG_BIN_HOME:-$HOME/.local/bin}" 
            echo "Added command to user :)"
        else 
            echo "The command is already installed on the user"
        fi
        ;;
    *sys*  | *SYS* ) 
        if [ ! -e "/usr/local/bin" ]; then
            echo "Adding command to system..."
            $SUPER mv -fu "$banampt"/src/banager/banager.sh /usr/local/bin 
            echo "Added command to system :)"
        else 
            echo "Command is already on the system"
        fi
        ;;
esac
mv -fu ./banager/config/config.sh "${XDG_CONFIG_HOME:-$HOME/.config}"
if [ -e "$HOME/.bashrc" ]; then 
    mv -fu "$HOME"/.bashrc "$HOME"/.bashrc.bak
    echo "Made .bashrc.bak"
fi
touch "$HOME"/.bashrc
echo -e "#!/usr/bin/env bash
\nbanager_config=\"\$XDG_DATA_HOME/banager/run/\"\n
# shellcheck source=/dev/null
\nsource -- \"\${XDG_DATA_HOME:-\$HOME/.local/share}/banager/run/config.sh\"" >> "$HOME"/.bashrc
cd ../ || exit 1
rm -rf "$banampt"
echo "Installed."
exit 0
