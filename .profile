#!/usr/bin/env sh
# ~/.profile
# Author: Jake Meredith
#

export EDITOR="nvim"
export READER="zathura"
export FILE="ranger"
export DISPLAY=:0
#export PAGER="most"
export GITCSS="$HOME/Documents/Resources/github-pandoc.css"
export ZDOTDIR="$HOME/.config/zsh"
#export TERMINAL="xterm-256color"
export TERMINAL="st"
export WSLENV="/mnt/s/tools"

# Prompt Colors
orange=$(tput setaf 202);
yellow=$(tput setaf 003);
green=$(tput setaf 012);
red=$(tput setaf 009);
blue=$(tput setaf 004);
purple=$(tput setaf 005);
white=$(tput setaf 007);
grey=$(tput setaf 236);
bold=$(tput bold);
reset=$(tput sgr0);

PS1="\[${green}\]\u";	# username
PS1+="\[${blue}\]@";			# @ symbol
PS1+="\[${purple}\]\h: ";		# host (computer name)
PS1+="\[${yellow}\]\W";			# working dir
PS1+="\[${green}\]\\$ ";		# '$' prompt
PS1+="\[${reset}\]";			# color reset
export PS1;

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
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in vim
stty -ixon

# Output monitor for X-server (GUI applications)
#export display=:0

# Automatically start tmux at login
#[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit;}
