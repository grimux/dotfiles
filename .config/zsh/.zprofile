#!/usr/bin/zsh
#
########################
### Default programs ###
########################
export EDITOR="nvim"
export READER="zathura"
export FILE="ranger"
export BROWSER="firefox"
export MUSIC="cantata"
#export MUSIC="alacritty --class ncmpcpp -e ncmpcpp"
export PAGER="less"
export LESS="--search-skip-screen --squeeze-blank-lines -rR --ignore-case --tabs=8"
export FILE="pcmanfm-qt"
export TERMINAL="alacritty"
export TERMCMD="$TERMINAL"


###################
### Environment ###
###################
export XDG_MUSIC_DIR="/mnt/s/music"

# Export GTK themes to Qt
export QT_QPA_PLATFORMTHEME=gtk2
#export QT_STYLE_OVERRIDE=kvantum
#export GTK_USE_PORTAL=1

# Directory for clipmenu.
export CM_DIR="$HOME/.cache/clipmenu"

## History in .config/zsh: ##
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.cache/zsh/history"

# SSH agent for passwordless login using ssh keys.
# Needs the `ssh-agent` service to be running.
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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
	PATH="$HOME/.local/bin/fun:$PATH"
	PATH="$HOME/.local/bin/peripherals:$PATH"
	PATH="$HOME/.local/bin/statusbar:$PATH"
	PATH="$HOME/.local/bin/dmenu:$PATH"
	PATH="$HOME/.local/bin/games:$PATH"
	PATH="$HOME/.local/bin/game-tools:$PATH"
	PATH="$HOME/.local/bin/steamdeck:$PATH"
	PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
fi


################
### MangoHud ###
################
#export MANGOHUD=1
#export MANGOHUD_DLSYM=1


##################
### Autostartx ###
##################
# .xinit file to use
XINITRC="$HOME/.xinitrc"
# If on tty1, and Xorg is not running, automatically startx with $XINITRC.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

