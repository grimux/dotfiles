#!/usr/bin/env bash
# ~/.profile
# Author: Jake Meredith
#

export EDITOR="nvim"
export READER="zathura"
export FILE="ranger"
export BROWSER="firefox"
#export PAGER="most"
export GITCSS="/mnt/s/documents/writing/github-pandoc.css"
export ZDOTDIR="$HOME/.config/zsh"
#export TERMINAL="xterm-256color"
export TERMINAL="alacritty"

# java application fix when using DWM
export _JAVA_AWT_WM_NONREPARENTING=1

# Export GTK themes to Qt
export QT_QPA_PLATFORMTHEME=gtk2

# Clipmenu settings
# clipmenu history location
export CM_DIR=$HOME/.cache/clipmenu
# Ignore copy from qtpass
export CM_IGNORE_WINDOW=QtPass

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# My Custom Aliases
# Use this to create custom commands that can run various other commands
if [ -f $HOME/.config/aliasrc ]; then
    . $HOME/.config/aliasrc
fi

# Config file shortcuts
if [ -f $HOME/.config/shortcutrc ]; then
    . $HOME/.config/shortcutrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
    PATH="$HOME/.local/bin/tools:$PATH"
    PATH="$HOME/.local/bin/statusbar:$PATH"
    PATH="$HOME/.local/bin/dmenu:$PATH"
    PATH="$HOME/.local/bin/games:$PATH"
fi

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in vim
stty -ixon

# MangoHud
#export MANGOHUD=1
#export MANGOHUD_DLSYM=1

# Automatically start tmux at login
#[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}

# Alias to load up nvm.  Usefull for avoiding long wsl startup time
#alias load_nvm='export NVM_DIR="$HOME/.local/nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
#alias node='unalias node npm && load_nvm && node'
#alias npm='unalias node npm && load_nvm && npm'

# Start graphical server on user's current tty if not already running.
XINITRC="/home/jake/.xinitrc"
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
