#!/usr/bin/env bash
# shellcheck source=/dev/null 
source -- /etc/os-release
case "$ID" in 
    *alpine*) PKG_MGR="apk" ;;
    *archlinux*) PKG_MGR="pacman" ;;
    *debian* | *ubuntu* | *mint*) PKG_MGR="apt" ;;
    *fedora*) PKG_MGR="dnf" ;;
    *opensuse*) PKG_MGR="zypper" ;;
    *) 
        case "$ID_LIKE" in 
            *alpine*) PKG_MGR="apk" ;;
            *archlinux*) PKG_MGR="pacman" ;;
            *debian* | *ubuntu* | *mint*) PKG_MGR="apt" ;;
            *fedora*) PKG_MGR="dnf" ;;
            *opensuse*) PKG_MGR="zypper" ;;
        esac
        ;;
esac
case "$PKG_MGR" in 
    pacman)
        INSTALL="-Sv --needed"
        REMOVE="-Rsu"
        UPDATE="--noconfirm -Syu --needed"
        # shellcheck disable=SC2034
        IGNORE="--ignore"
        ;;
    *)
        # shellcheck disable=SC2034
        INSTALL="install"
        # shellcheck disable=SC2034
        REMOVE="remove"
        # shellcheck disable=SC2034
        UPDATE="update -y"
        ;;
esac
