#!/usr/bin/env bash
#
# Shell profile for zsh
#
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
export CM_DIR="$HOME/.cache/clipmenu"


############
### Path ###
############
# Add .local/bin and a few subdirectories to PATH.
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
	#PATH="$HOME/.local/bin/laptop:$PATH"
	PATH="$HOME/.local/bin/tools:$PATH"
	PATH="$HOME/.local/bin/toggles:$PATH"
	PATH="$HOME/.local/bin/phone:$PATH"
	PATH="$HOME/.local/bin/statusbar:$PATH"
	PATH="$HOME/.local/bin/dmenu:$PATH"
	PATH="$HOME/.local/bin/games:$PATH"
fi


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


########################
### General Settings ###
########################
# Enable colors
autoload -U colors && colors

## History in .config/zsh: ##
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"

## Basic auto/tab complete ##
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
export LC_ALL=en_US.UTF-8

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in the terminal.
stty -ixon

# Bind "Home", "End", and "Delete" to operate as expected.
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char


########################
### vi mode settings ###
########################
bindkey -v
export KEYTIMEOUT=1

## Use vim keys in tab complete menu: ##
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

## Edit line in vim with ctrl-e: ##
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

## Change cursor shape for different vi modes. ##
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


###############
### Aliases ###
###############
## General ##
#alias ls="ls --color=auto --group-directories-first"
#alias la="ls -lA --color=auto --group-directories-first"
alias ls="lsd -1 --group-directories-first"
alias la="lsd --almost-all --long --group-directories-first"
alias lu="lsd --sizesort --almost-all --total-size --long --group-directories-first"
alias lss="/usr/bin/ls -1 --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias f="ranger"
alias sf="sudo ranger"
alias x="exit"
alias vim="nvim"
alias sdn="shutdown now"
alias trem="transmission-remote"
alias py="python"
alias ka="killall"
alias pt="protontricks"

## Dotfile alias ##
alias config="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"

## yt-dlp ##
alias ytv="yt-dlp --config-location ~/.config/youtube-dl/video_single"
alias yta="yt-dlp --config-location ~/.config/youtube-dl/audio_single"
alias ytap="yt-dlp --config-location ~/.config/youtube-dl/audio_playlist"
alias ytas="yt-dlp --config-location ~/.config/youtube-dl/audio_split"
alias ytvp="yt-dlp --config-location ~/.config/youtube-dl/video_playlist"
alias ytpod="yt-dlp --config-location ~/.config/youtube-dl/podcast"

## Games ##

## Directories ##
alias gc="cd /mnt/x/game-stuff/game-collection"
alias steamdir="cd $HOME/.steam/steam"


#################
### Functions ###
#################
# Prevent nested ranger instances.  From archwiki.
# url: https://wiki.archlinux.org/title/Ranger#Preventing_nested_ranger_instances
ranger() {
	if [ -z "$RANGER_LEVEL" ]; then
		/usr/bin/ranger "$@"
	else
		exit
	fi
}

## Use ranger to switch directories ##
rangercd () {
	tmp="$(mktemp)"
	ranger --choosedir="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
# ctrl+o
bindkey -s '^o' 'rangercd\n'

# a fix for slow git tab completion?
__git_files () {
	_wanted files expl 'local files' _files
}

## Vimwiki Function ##
# This will either open vimwiki, or you can use git.
# usage: vimwiki git
vimwiki () {
	if [[ $# == 0 ]]
	then
		nvim +'VimwikiIndex'
	elif [[ $1 == 'git' ]]
	then
		git -C ~/vimwiki/ ${@:2}
	else
		echo 'Usage: vimwiki [git] [args ...]'
	fi
}


##################
### Autostartx ###
##################
# .xinit file to use
XINITRC=$HOME/.xinitrc
# If on tty1, and Xorg is not running, automatically startx with $XINITRC.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"


################
### MangoHud ###
################
#export MANGOHUD=1
#export MANGOHUD_DLSYM=1


#######################
### Prompt Settings ###
#######################
# My favorite
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~%{$fg[red]%}]%{$reset_color%}$%b "

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# starship prompt
eval "$(starship init zsh)"

# colorscript on launch
#colorscript random

# Neofetch
neofetch
