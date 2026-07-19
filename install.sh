#!/bin/bash
cd /tmp/ || exit 1
echo ls ./
echo "Cloning in /tmp..."
git clone https://codeberg.org/RubyRose/banager.git 
echo "Removing dev and useless files and folders..."
rm -rf banager/install.sh banager/docs/
echo "Making the config and data files..."
mkdir "$HOME"/.local/share/banager
mv ./banager/deps/ ./banager/commands/ "$HOME"/.local/share/banager
mv ./banager "${XDG_CONFIG_HOME:-$HOME/.config}"
mv "$HOME"/.bashrc "$HOME"/.bashrc.bak
touch "$HOME"/.bashrc
if ! grep "source -- \"${XDG_CONFIG_HOME:-$HOME/.config}/banager/config\""; then
    echo -e "#!/bin/bash\nsource -- \"$HOME/.config/banager/config\"" >> "$HOME"/.bashrc
fi
echo "Checking the plugins..."
banager_config="${XDG_CONFIG_HOME:-$HOME/.config}/banager"
command -v pacman &>/dev/null || rm -f "$banager_config/plugins/archlinux.plugin.sh"
command -v nix &>/dev/null || rm -f "$banager_config/plugins/nixos.plugin.sh"
echo "Installed."
exit 0
