#!/usr/bin/env bash
#
# xinit script for Xorg.
#
# by: Jake
#


###################
### Fail Events ###
###################
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
# E - same as: `-o errexit -o errtrace`.  Needed for `trap` command.
#
set -eo pipefail


##################
### User Input ###
##################
# Set awesome as the default, otherwise the argument passed will be the session.
session=${1:-awesome}


##############
### Config ###
##############
#
# Flag for debug mode.
# When enabled, only loads the bare minimum of things, using Awesome.
DEBUG=0


################
### Sessions ###
################
#
# AwesomeWM config
function awesome() {
	# Picom for transparency
	picom &

	# Start policy kit
	lxsession &


	### Wallpaper is now set within AwesomeWM. ###

	# Restore wallpaper using Nitrogen
	#nitrogen --restore &

	# Restore wallpaper using feh
	#~/.fehbg &

	# Run custom signals for awesome/lain status bar
	#~/.config/awesome/custom_signals.sh &

	# Redshift for bluelight filter
	# Use either the gtk tray icon or not.  Use `redshift -p` to check status.
	redshift-gtk &
	#redshift &

	export XDG_SESSION_TYPE='x11'
	export XDG_CURRENT_DESKTOP='gtk'
	#export XDG_CURRENT_DESKTOP='awesome'
	#export XDG_CURRENT_DESKTOP='LXQt'

	# Start awesome
	exec awesome
}

# Gnome config
function gnome() {
	# Set session to xorg
	export XDG_SESSION_TYPE=x11

	# Set session to xorg
	export GDK_BACKEND=x11

	# Turn on screensaver
	#xscreensaver --no-splash &

	# Start the session
	exec gnome-session
}

# DWM config
function dwm() {
	# Start dwmblocks
	dwmblocks &

	# Dunst for notifications
	dunst &

	# Start conky
	conky -c ~/.config/conky/conkyrc.dwm &

	# Start dwm
	exec dwm
}

# KDE plasma config
function plasma() {
	export DESKTOP_SESSION=plasma
	exec startplasma-x11
}

# Debug mode
function debug_session() {
	export XDG_SESSION_TYPE='x11'
	export XDG_CURRENT_DESKTOP='gtk'

	exec awesome
}


#######################
### Shared Settings ###
#######################
#
# General settings shared by all session types.
function shared_settings() {
	# ID names from xrandr for my TV and PC monitor.
	local monitor_id="DVI-D-0"
	local tv_id="HDMI-0"

	# Set TV (hdmi) to be the same as main monitor
	xrandr --output $tv_id --same-as $monitor_id &

	# OpenRGB for PC's RGB lighting.
	#openrgb --server --profile Rainbow.orp --startminimized &
	openrgb --server --profile default_profile --startminimized &

	# Turn on the numlock
	numlockx on &

	# Clipmen daemon
	clipmenud &

	# Blankout screen after 15 minutes
	xset s 900 &
	xset dpms 900 900 900 &

}


########################
### Unsused Settings ###
########################
#
# Some settings that I'm not currently using, but want to keep in case I need them again.
# These settings are from "shared_settings", and are removed to simplfy the function.
function unsused_settings() {
	# music player daemon
	# Note: currently using systemd user service.
	# Check if the pid file exists, if not, start mpd.
	# If file exists and size greater than zero (-s), skip.
	[ ! -s ~/.local/share/mpd/pid ] && mpd
	[[ $(pgrep mpd) ]] && mpd &

	# mpd notifications
	# Note: currently using systemd user service.
	#mpd-notification &

	# control mpd with playerctl
	#mpDris2 &

	# Set caps lock to escape
	setxkbmap -option caps:escape &

	# Gerbera media server
	gerbera --daemon &

	# Power Management
	powerkit &

	# Start playerctl daemon, tracks recent media players and can control them with media keys.
	playerctld daemon &

	# Start Universal Media Server
	# Currently using systemd service.
	ums &

	# From: awesome session
	# Fix for steam
	/usr/lib/xdg-desktop-portal-gtk &
	/usr/lib/xdg-desktop-portal-lxqt &
	/usr/lib/xdg-desktop-portal &

}

# Source the startup scripts for X11.
# Loop through directory and source each one.
function source_startup_files() {
	if [ -d /etc/X11/xinit/xinitrc.d ]; then
		for f in /etc/X11/xinit/xinitrc.d/*; do
			[ -x "$f" ] && . "$f"
		done
		unset f
	fi
}


############
### Main ###
############
# Main function.
# Contains startup scripts, shared settings, and case statement to determine desktop environment.
function main() {
	# Source all startup scripts for X11.
	# Contains an important one to set DISPLAY properly.
	source_startup_files

	# Run the shared settings first.
	shared_settings

	# Switch to determine which window manager we want to execute.
	case "$session" in
		awesome|awm	) awesome;;
		dwm		) dwm;;
		gnome		) gnome;;
		plasma|kde	) plasma;;
		*		) echo "Session not found." && exit 1
	esac
}


#############
### Debug ###
#############
# Called below if "debug" is passed as the session name.
# Only loads very minimal things to help in debugging problems.
function main_debug() {
	set -euox pipefail
	debug_session
}

# Check for debug mode.
# Call main otherwise.
if [ "$session" == "debug" ]; then
	DEBUG=1
	main_debug
	exit 1
fi

main
