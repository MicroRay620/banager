#!/bin/bash
source "$HOME/.config/banager/banager.conf"
if [ "$enable_alias" = "true" ]; then 
    # shellcheck disable=SC1091
    source -- "$XDG_DATA_HOME/banager/commands/alt-command.sh"
    source -- "$XDG_DATA_HOME/banager/commands/package_managers.sh"
    alias restart="reboot"
    alias poxbash="bash --posix"
    alias shoot='$SUPER pkill'
    alias grep='$GREP'
    alias du='$DU'
    alias find='$FIND'
    alias cat='$CAT'
    # These make it easier for you to install packages without having to remember which package manager you're using or the arguements
    # For the info on this, the checks are under Package Manager Checks to
    alias pacinstall='$SUPER $PKG_MGR $INSTALL' 
    alias pacremove='$SUPER $PKG_MGR $REMOVE'
    alias pacupdate='$SUPER $PKG_MGR $UPDATE'
    if command -v gtrash &>/dev/null; then 
        alias rm='gtrash put'
    fi
    # These are for if you have timeshift.
    # Don't use these if you don't have timeshift
    # timeshift is a good partition backup for everything except nixos
    if ! command -v nix &>/dev/null; then 
        alias backup='$SUPER timeshift --create'
        alias restore='$SUPER timeshift --restore --snapshot'
        alias shotlist='$SUPER timeshift --list-snapshots'
        alias killsnapshot='$SUPER timeshift --delete'
        alias genocidesnapshots='$SUPER timeshift --delete-all --yes'
    fi
    if command -v swww &>/dev/null; then 
        # awww is updated version of swww
        alias awww=swww
    fi
    if command -v youtube-tui &>/dev/null; then 
        alias yt-tui="youtube-tui"
    fi
    if command -v yt-dlp &>/dev/null; then 
        alias yt-dlp='yt-dlp -4w --no-cookies-from-browser --audio-quality 0 ' # A change for the defauult command
        alias mp3-dl="yt-dlp --audio-format mp3" # Good for downloading mp3 files
        alias svr-download="yt-dlp --write-info-json --write-subs --no-write-auto-subs" # This is intended for adding videos to a database/server
    fi
fi
if [ "$distro_aliases" = "true" ]; then
    if [ "$PKG_MGR" = "pacman" ]; then
        alias pacman='$SUPER pacman' # Will make a alias for every package manager
        alias pacignore='$SUPER $PKG_MGR $IGNORE'
        alias extpacinstall='$SUPER $PKG_MGR -U'

        alias aurinstall='$AUR $INSTALL'
        alias aurremove='$AUR $REMOVE'

        alias aurupdate='$AUR $UPDATE'

        if command -v downgrade &>/dev/null; then
            # For configuring, please do `$ man downgrade` or `$ downgrade --help`
            # INFO: downgrade is only on Arch
            alias downgrade='$SUPER downgrade' # This is to make using the command easier
        fi
        # To update just type in your AUR manager for this, can be done with `$ paru` or `$ yay`
        # the `else` is no longer necessary, adding pacupdate for all distros for simplicity sake 
    elif [ "$PKG_MGR" = "nix" ]; then 
        # NIXOS ALIASES
        # shellcheck disable=SC2153
        alias nixos-rebuild='cd $NIX_PATH && $SUPER nixos-rebuild'
        alias nix-store='$SUPER nix-store'
        alias nix-collect-garbage='$SUPER nix-collect-garbage'
        alias nix-add='cd $HOME/nixos && nvim'
    fi
fi
