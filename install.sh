#!/bin/bash
banampt=$(mktemp -d banampt.XXXXXX)
cd "$banampt" || exit 1

supers=$("sudo" "doas")
for super in "${supers[@]}"; do 
    if $super &>/dev/null; then 
        SUPER="$super"
        break
    fi
done

git clone https://codeberg.org/RubyRose/banager.git 

echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/
echo "Making the config and data files..."

mkdir "$HOME"/.local/share/banager
mv ./banager/deps/ ./banager/commands/ "$HOME"/.local/share/banager
echo "Install for [user] or [system]? "
echo "On NixOS system, it's recommended to do user"
read -r install_choice
echo "Adding the command..."
case "$install_choice" in 
    *user* | *USER*) cp -f ./commands/banager/banager.sh "$HOME/.local/bin/" ;;
    *sys*  | *SYS* ) $SUPER cp -f ./commands/banager/banager.sh /usr/local/bin ;;
esac
mv ./banager "${XDG_CONFIG_HOME:-$HOME/.config}"
mv "$HOME"/.bashrc "$HOME"/.bashrc.bak
touch "$HOME"/.bashrc
if [ -e "$HOME/.bashrc" ]; then 
    echo -e "#!/bin/bash\nsource -- \"\$(bastore)\"/config.sh" >> "$HOME"/.bashrc
fi

rm -rf "$banampt"

# echo "Checking the plugins..."
# banager_config="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
# supported=( "nixos" "archlinux" "cachyos" "endeavouros" "manjaro" "garuda" )
# shellcheck disable=SC1091
source /etc/os-release
# TODO: Make a check to autodelete the unused and unsupported distro plugins

echo "Installed."
exit 0
