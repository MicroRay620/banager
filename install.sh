#!/bin/bash
supers=( "sudo" "doas" )
for super in "${supers[@]}"; do 
    if command -v "$super" &>/dev/null; then 
        SUPER="$super"
    fi
done
"$SUPER" cd /tmp/ || exit 1
git clone https://codeberg.org/RubyRose/banager.git 
rm -rf banager/install.sh banager/docs/
"$SUPER" mv banager "${XDG_CONFIG_HOME:-$HOME/.config}"
echo -e "source -- \"${XDG_CONFIG_HOME:-$HOME/.config}/banager\"" >> "$HOME"/.bashrc
