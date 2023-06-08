#!/usr/bin/env bash
#
# Shell profile for zsh
# Written by Jake
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
export TERMCMD="$TERMINAL"
# Export GTK themes to Qt
export QT_QPA_PLATFORMTHEME=gtk2
export CM_DIR="$HOME/.cache/clipmenu"


########################
### Global variables ###
########################
export yt_app="yt-dlp --config-location"
export yt_config_location="~/.config/youtube-dl"
export video_playlist_dir="/mnt/v/playlists"

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
	PATH="$HOME/.local/bin/steamdeck:$PATH"
	PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
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

## History searching
# Begin typing command to search, then use up and down arrow keys.
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

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

## ls/lsd, grep ##
#alias ls="ls --color=auto --group-directories-first"
#alias la="ls -lA --color=auto --group-directories-first"
alias ls="lsd -1 --group-directories-first"
alias la="lsd --almost-all --long --group-directories-first"
alias lu="lsd --sizesort --almost-all --total-size --long --group-directories-first"
alias lss="/usr/bin/ls -1 --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias searchtext="grep -R --color=auto"

## Config files ##
alias cfa="$EDITOR ~/.zshrc -c /Aliases"
alias cfv="$EDITOR ~/.config/nvim/init.vim"
alias cfx="$EDITOR ~/.xinitrc"
alias cfz="$EDITOR ~/.zshrc"
alias cfb="$EDITOR ~/Videos/playlists/bedtime.m3u"
alias cfs="$EDITOR ~/.config/script_boilerplate.sh"

## Program shortcuts ##
alias define="sdcv"			# Dictionary
alias f="ranger"
alias ka="killall"
alias ncm="ncmpcpp"			# Terminal music player for mpd
alias pt="protontricks"
alias py="python"
alias sdn="shutdown now"
alias sf="sudo ranger"			# Run ranger as root
alias spell="look"
alias tar-backup="tar cvfpz"
alias tar-restore="tar xvfpz"
alias trem="transmission-remote"
alias vimhelp="nvim -c help -c only"	# Open the help section of nvim
alias vim="nvim"
alias weather="curl wttr.in"		# Get the current weather
alias x="exit"
alias rsync-fat="rsync -hvrltD --modify-window=1 --stats --info=progress2"
alias mountsd="sudo mount /dev/sdf1"
alias getsub="subdl --username grimux --password ahb0oaSuG3iPohk@ --download=most-downloaded --existing=query"
alias movies="ranger ~/Videos/movies"

## Dotfile alias ##
# An alias to manage my dotfiles.
alias config="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"

## yt-dlp ##
alias yta="$yt_app $yt_config_location/audio_single"
alias ytap="$yt_app $yt_config_location/audio_playlist"
alias ytas="$yt_app $yt_config_location/audio_split"
alias ytpod="$yt_app $yt_config_location/podcast"
alias ytv="$yt_app $yt_config_location/video_single"
alias ytvp="$yt_app $yt_config_location/video_playlist"

# Copy game files using rsync
alias send_game="rsync -hvrlt --info=progress2 --stats"

## Games ##
#alias im_stuck="steam -applaunch 1010750 map e1m1"
alias im_stuck="nblood"

## Music ##
alias dangan="mpc clear; mpc searchadd Title \"Into Free\"; mpc play; lyrics"
alias meditation="mpv /mnt/s/music/meditation/jon_kabat_meditation.mp3"
alias playback="mpc clear; mpc searchadd Artist \"Forth Right MC\"; mpc play"

## Video Playlists ##
mpv_playlist_settings="--loop-playlist --save-position-on-quit"
alias factorio="mpv $mpv_playlist_settings $video_playlist_dir/factorio_1.0_tuplex.m3u"
alias futurama="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/futurama.m3u"
alias subnautica="mpv $mpv_playlist_settings $video_playlist_dir/subnautica.m3u"
alias spongebob="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/spongebob.m3u"
alias blood="mpv $mpv_playlist_settings $video_playlist_dir/blood_fresh_supply.m3u"
alias xavier="mpv $mpv_playlist_settings $video_playlist_dir/xavier.m3u"
alias xfiles="mpv $mpv_playlist_settings $video_playlist_dir/xfiles.m3u"
alias twinpeaks="mpv $mpv_playlist_settings $video_playlist_dir/twin_peaks.m3u"

alias calm="mpv --loop --fullscreen /mnt/v/relaxing/Autism_Calming_Sensory_Meltdown_Remedy_Soothing_Visuals-Super_Duper_Fun_Music.mkv"

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

# Countdown timer
# pass time in seconds
countdown() {
	start="$(( $(date '+%s') + $1))"
	while [ $start -ge $(date +%s) ]; do
		time="$(( $start - $(date +%s) ))"
		printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
		sleep 0.1
	done
}

# Stopwatch
stopwatch() {
	start=$(date +%s)
	while true; do
		time="$(( $(date +%s) - $start))"
		printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
		sleep 0.1
	done
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
