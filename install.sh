#!/bin/bash
cd /tmp/ || exit 1
echo ls ./
echo "Cloning in /tmp..."
git clone https://codeberg.org/RubyRose/banager.git 
echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/
echo "Making the config file..."
mv ./banager "${XDG_CONFIG_HOME:-$HOME/.config}"
if ! grep -Fq "source -- \"${XDG_CONFIG_HOME:-$HOME/.config}/banager/config\""; then
    echo "source -- \"${XDG_CONFIG_HOME:-$HOME/.config}/banager/config\"" >> "$HOME"/.bashrc
fi
echo "Checking the plugins..."
banager_config="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
command -v pacman &>/dev/null || rm -f "$banager_config/plugins/archlinux.plugin.sh"
command -v nix &>/dev/null || rm -f "$banager_config/plugins/nixos.plugin.sh"
echo "Installed."
exit 0
