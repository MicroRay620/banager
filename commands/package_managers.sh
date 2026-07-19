#!/bin/bash
# Package Manager check
# Gentoo will be added, just not by me
# 
# Add a boolean to check if it's supported or not 
# This is for the multi-package manager check
# TODO: make it so multiple package managers will work
export managers=("apk" "apt" "dnf" "pacman" "pup" "zypper") # For a multimanager list
# This will run a for loop for all the package managers 
# May be simplier than doing all if statements for them, less code is nice code :)
for item in "${managers[@]}"; do 
    if command -v "$item" &>/dev/null; then 
        export PKG_MGR="$item"
        # This is for the AUR checks
        break
    else 
        continue
    fi
done 
# This is the AUR check 
# Tried having it in the previous for loop but it sadly failed

# Flag check 
# To add user level to these you can just add the flag
if [[ ! "$PKG_MGR" = "pacman" ]]; then 
    # For the flags, please check the man page for your package manager.
    # For the ones in Ruby's dotfile copy of .bashrc:
    # Alpine: `$ man apk`
    # Debian/Ubuntu: `$ man apt`
    # Fedora: `$ man dnf`
    # openSUSE: `$ man zypper`
    # There is no man page for the Slackware version of Puppy Linux
    export nocomf_INSTALL="install -y"
    export nocomf_REMOVE="remove -y"    

    
    export UPDATE="update -y"
    
    export INSTALL="install"
    export REMOVE="remove"
else 
    # For all the possible options, please run `$ man pacman`
    # You can also run `$ man paru` or `$ man yay` for the AUR managers
    export nocomf_INSTALL="--noconfirm -Sv --needed"
    export nocomf_REMOVE="--noconfirm -Rsu"

    export INSTALL="-Sv --needed"
    export REMOVE="-Rsu"

    export UPDATE="--noconfirm -Su --needed" # Adding this for some extra and standard use

    export IGNORE="--ignore"
    # If it was easier to impliment on the other distros, I would have it included
fi

