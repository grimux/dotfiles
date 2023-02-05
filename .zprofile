#!/usr/bin/env bash
#
# Shell profile for zsh
#
# Author: Jake Meredith
#

########################
### Default programs ###
########################
export EDITOR="nvim"
export READER="zathura"
export FILE="ranger"
export BROWSER="firefox"
#export PAGER="most"
export TERMINAL="alacritty"
# Export GTK themes to Qt
export QT_QPA_PLATFORMTHEME=gtk2

###################
### Directories ###
###################
# clipmenu history location
export CM_DIR="$HOME/.cache/clipmenu"
# Ignore copy from qtpass
export CM_IGNORE_WINDOW="QtPass"
export ZDOTDIR="$HOME/.config/zsh"

#######################
### less/man colors ###
#######################
export LESS="-R"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"


###############
### Aliases ###
###############
# My shell aliases file.
if [ -f "$HOME/.config/aliasrc" ]; then
    source "$HOME/.config/aliasrc"
fi

# Config file shortcuts
if [ -f "$HOME/.config/shortcutrc" ]; then
    source "$HOME/.config/shortcutrc"
fi


############
### Path ###
############
# Add .local/bin and a few subdirectories to PATH.
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
    PATH="$HOME/.local/bin/laptop:$PATH"
    PATH="$HOME/.local/bin/tools:$PATH"
    PATH="$HOME/.local/bin/statusbar:$PATH"
    PATH="$HOME/.local/bin/dmenu:$PATH"
    PATH="$HOME/.local/bin/games:$PATH"
fi

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in the terminal.
stty -ixon

################
### MangoHud ###
################
#export MANGOHUD=1
#export MANGOHUD_DLSYM=1

##################
### Autostartx ###
##################
# .xinit file to use
XINITRC=/home/jake/.xinitrc
# If on tty1, and Xorg is not running, automatically startx with $XINITRC.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
