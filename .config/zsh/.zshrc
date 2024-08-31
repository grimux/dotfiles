#!/usr/bin/env bash
#
# Shell profile for zsh
# Written by Jake
#
#
########################
### General Settings ###
########################
# Enable colors
autoload -U colors && colors

## History searching
# Begin typing command to search, then use up and down arrow keys.
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

## Source aliases file
ALIAS_FILE="$HOME/.config/aliases.sh"
if [ -f "$ALIAS_FILE" ]; then
	source "$ALIAS_FILE"
else
	echo "Error: Alias file not found."
	echo "Location should be: $ALIAS_FILE"
fi

## Basic auto/tab complete ##
autoload -Uz compinit
zstyle ':completion:*' menu select
#zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
compinit
export LC_ALL=en_US.UTF-8

# Disable the ctrl-s and ctrl-q shortcuts, which disable/enable keyboard input in the terminal.
stty -ixon

# Bind "Home", "End", and "Delete" to operate as expected.
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

DISABLE_AUTO_TITLE="false"

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

#################
### Functions ###
#################
# Prevent nested ranger instances.  From Arch Wiki.
# url: https://wiki.archlinux.org/title/Ranger#Preventing_nested_ranger_instances
ranger() {
	if [ -z "$RANGER_LEVEL" ]; then
		/usr/bin/ranger "$@"
	else
		exit
	fi
}

## Use ranger to switch directories ##
rangercd() {
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

# When exiting `yazi`, cd to the directory.
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

############################
### Dynamic window title ###
############################
# Taken from Arch Wiki
# url: https://wiki.archlinux.org/title/Zsh#xterm_title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- "\e]2; ${(q)1}\a"
	#print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm\_title\_precmd
	add-zsh-hook -Uz preexec xterm\_title\_preexec
fi

##################
### Autostartx ###
##################
# .xinit file to use
#XINITRC=$HOME/.xinitrc
# If on tty1, and Xorg is not running, automatically startx with $XINITRC.
#[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

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
#neofetch
