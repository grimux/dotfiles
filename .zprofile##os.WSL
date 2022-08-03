#!/usr/bin/env sh
# ~/.profile
# Author: Jake Meredith
#

export EDITOR="nvim"
export READER="zathura"
export FILE="lf"
export BROWSER="firefox"
#export PAGER="most"
export GITCSS="/mnt/s/documents/writing/github-pandoc.css"
export ZDOTDIR="$HOME/.config/zsh"
#export TERMINAL="xterm-256color"
export TERMINAL="st"
export WSLENV="/mnt/s/tools:/mnt/c/Program\ Files/SumatraPDF"

# password location, on the Windows side
#export PASSWORD_STORE_DIR="/mnt/s/.password-store"

# RVM and ruby paths
export GEM_HOME="$HOME/.rvm/gems"
export GEM_PATH="$HOME/.rvm/gems/ruby-3.0.0/bin"

### WSL 2 Configuration ###
# IP address of WSL
export HOST_NAME=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
# Display for VcxSrv
export DISPLAY=$HOST_NAME:0
# PulseAudio server
export PULSE_SERVER=tcp:$HOST_NAME

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# qt theme-ing from gtk
export QT_QPA_PLATFORMTHEME="qt5ct"

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
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
    PATH="$HOME/.local/bin/laptop:$PATH"
    PATH="$HOME/.local/bin/statusbar:$PATH"
    PATH="$HOME/.local/bin/wsl:$PATH"
    PATH="$HOME/.rvm/gems/ruby-3.0.0/bin:$PATH"
    PATH="$HOME/.rvm/gems/ruby-3.0.0/wrappers:$PATH"
fi

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in vim
stty -ixon

# Output monitor for X-server (GUI applications)
#export display=:0

# Automatically start tmux at login
#[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}

# Alias to load up nvm.  Usefull for avoiding long wsl startup time
alias load_nvm='export NVM_DIR="$HOME/.local/nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
alias node='unalias node npm && load_nvm && node'
alias npm='unalias node npm && load_nvm && npm'
