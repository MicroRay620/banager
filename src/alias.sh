#!/usr/bin/env bash
# shellcheck source=/dev/null
source /etc/os-release 
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/package_managers.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh"
for supers in doas sudo sudo-rs; do
    if command -v "$supers" &>/dev/null; then 
        SUPER="$supers"
        break 
    else 
        continue
    fi
done
alias restart="reboot"
alias posh="bash --posix"
alias shoot='$SUPER pkill'
# These make it easier for you to install packages without having to remember which package manager you're using or the arguements
# For the info on this, the checks are under Package Manager Checks to
alias pacadd='$SUPER $PKG_MGR $INSTALL' 
alias pacrm='$SUPER $PKG_MGR $REMOVE'
alias pacudate='$SUPER $PKG_MGR $UPDATE'
if command -v gtrash &>/dev/null; then 
    alias rm='gtrash put'
fi

# These are for if you have timeshift.
# Don't use these if you don't have timeshift
# timeshift is a good partition backup for everything except nixos
if command -v timeshift &>/dev/null; then 
    alias backup='$SUPER timeshift --create'
    alias restore='$SUPER timeshift --restore --snapshot'
    alias shotlist='$SUPER timeshift --list-snapshots'
    alias killsnap='$SUPER timeshift --delete'
    alias ukillsnap='$SUPER timeshift --delete-all --yes'
fi
# shellcheck disable=SC2154
if [ "$yt_alias" = "true" ]; then 
    if command -v yt-dlp &>/dev/null; then 
        alias yt-dlp='yt-dlp -4w --no-cookies-from-browser --audio-quality 0 ' # A change for the defauult command
        alias mp3-dl="yt-dlp --audio-format mp3" # Good for downloading mp3 files
        alias svr-download="yt-dlp --write-info-json --write-subs --no-write-auto-subs" # This is intended for adding videos to a database/server
    else 
        echo -e "\e[31mBC1: You have yt_alias set to true in your banager config but yt-dlp is not installed.\e[0m\n Please install install or set yt_alias to false"
    fi
fi

# NOTE: THESE ALIASES MAY BE REMOVED AT A LATER DATE
if command -v youtube-tui &>/dev/null; then 
    alias yt-tui="youtube-tui"
fi


