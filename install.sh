#!/bin/bash
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

git clone https://codeberg.org/RubyRose/banager.git 

echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/
echo "Making the config and data files..."

mkdir "$HOME"/.local/share/banager
mv -fu ./banager/deps/ ./banager/commands/ "$HOME"/.local/share/banager
echo "Install for [user] or [system]? "
echo "On NixOS system, it's recommended to do user"
read -r install_choice
echo "Adding the command..."
case "$install_choice" in 
    *user* | *USER*) mv -fu "$banampt"/commands/banager/banager.sh "$HOME/.local/bin/" ;;
    *sys*  | *SYS* ) $SUPER mv -fu "$banampt"/commands/banager/banager.sh /usr/local/bin ;;
esac
mv -fu ./banager "${XDG_CONFIG_HOME:-$HOME/.config}"
mv -fu "$HOME"/.bashrc "$HOME"/.bashrc.bak
touch "$HOME"/.bashrc
if [ -e "$HOME/.bashrc" ]; then 
    if command -v ble-update &>/dev/null; then 
        echo "Use either: https://github.com/akinomyoga/ble.sh#13-set-up-bashrc or https://github.com/akinomyoga/ble.sh#13-set-up-bashrc"
    elif command -v blesh-share &>/dev/null; then 
        echo "source -- \"\$(blesh-share)\"/ble.sh" >> "$HOME"/.bashrc
    fi
    # The banager_config="$XDG_DATA_HOME/banager/deps/" source -- "$banager_config"/config.sh is temporary until I can get $banater to work in the source
    echo -e "#!/usr/bin/env bash\nbanager_config=\"\$XDG_DATA_HOME/banager/deps/\"# shellcheck source=/dev/null\nsource -- \"\$banager_config\"/config.sh" >> "$HOME"/.bashrc
fi
rm -rf "$banampt"

echo "Installed."
exit 0
