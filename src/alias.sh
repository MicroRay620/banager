#!/usr/bin/env bash
# shellcheck disable=SC2154 source=/dev/null
source /etc/os-release 
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/package_managers.sh"
source -- "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/declare.sh"
source -- "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config"
if command -v doas &>/dev/null; then 
    SUPER=doas 
elif command -v sudo &>/dev/null; then 
    SUPER=sudo 
elif command -v sudo-rs &>/dev/null; then 
    SUPER=sudo-rs 
fi
# NOTE: This is found in ~/.local/banager/src/declare.sh
echo "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: \$SUPER is $SUPER" >> "$log_file"
alias restart="reboot"
alias bosh="bash --posix" # INFO: This just means Bash pOsix SHell
alias shoot='$SUPER pkill'
# These make it easier for you to install packages without having to remember which package manager you're using or the arguements
# For the info on this, the checks are under Package Manager Checks to
alias pacadd='$SUPER $PKG_MGR $INSTALL' 
alias pacrm='$SUPER $PKG_MGR $REMOVE'
alias pacudate='$SUPER $PKG_MGR $UPDATE'
alias please='$SUPER $(fc -ln -1)'
# These are for if you have timeshift.
# Don't use these if you don't have timeshift
# timeshift is a good partition backup for everything except nixos
if [ "$time" = "true" ]; then
    echo "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh: \$time is enabled" >> "$log_file"
    if command -v timeshift &>/dev/null; then 
        alias backup='$SUPER timeshift --create'
        alias restore='$SUPER timeshift --restore --snapshot'
        alias shotlist='$SUPER timeshift --list-snapshots'
        alias killsnap='$SUPER timeshift --delete'
        alias ukillsnap='$SUPER timeshift --delete-all --yes'
        echo -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: timeshift command found; enabled timeshift aliases" >> "$log_file"
    else
        echo -e "\e[31mBC1 Error: You have time enabled in banager/config.sh but timeshift isn't installed\e[0m"
        echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: Error:BC1: timeshift command not installed\e[0m" >> "$log_file"
        exit 1
    fi
fi
if [ "$yt_alias" = "true" ]; then 
    echo "${XDG_CONFIG_HOME:-$HOME/.config}/banager/config.sh: \$yt_alias is enabled" >> "$log_file"
    if command -v yt-dlp &>/dev/null; then 
        alias yt-dlp='yt-dlp -4w --no-cookies-from-browser --audio-quality 0 ' # A change for the defauult command
        alias mp3-dl="yt-dlp --audio-format mp3" # Good for downloading mp3 files
        alias svr-download="yt-dlp --write-info-json --write-subs --no-write-auto-subs" # This is intended for adding videos to a database/server
        echo -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: yt-dlp command found; enabled yt-dlp aliases" >> "$log_file"
    else 
        echo -e "\e[31mBC1: You have yt_alias set to true in your banager config but yt-dlp is not installed.\e[0m\n Please install install or set yt_alias to false"
        echo -e "\e[31m${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: Error BC1: yt-dlp command not installed\e[0m" >> "$log_file"
        exit 1
    fi
    if command -v youtube-tui &>/dev/null; then 
        alias yt-tui="youtube-tui"
        echo -e "${XDG_DATA_HOME:-$HOME/.local/share}/banager/src/alias.sh: youtube-tui command found; enabled youtube-tui alias" >> "$log_file"
    fi
fi
