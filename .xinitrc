#!/bin/sh
# 
# xinit script
#

# Set awesome as the default, otherwise the argument passed will be the session.
session=${1:-awesome}

# AwesomeWM config
awesome() {
	# Not using volumeicon at the moment, I prefer pasystray.
	#volumeicon &
	
	# pasystray should start automatically.
	#pasystray -g &
	
	exec awesome					# Start awesome
}

# Gnome config
gnome() {
	export XDG_SESSION_TYPE=x11		# Set session to xorg
	export GDK_BACKEND=x11			# Set session to xorg
	xscreensaver --no-splash &		# Turn on screensaver
	exec gnome-session			# Start the session
}

# DWM config
dwm() {
	dwmblocks &					# Start dwmblocks
	dunst &						# Dunst for notifications
	conky -c ~/.config/conky/conkyrc.dwm &		# Start conky
	exec dwm					# Start dwm
}

# KDE plasma config
plasma() {
	export DESKTOP_SESSION=plasma
	exec startplasma-x11				# Start plasma
}

# General settings shared by all configs.
shared_settings() {
	# ID names from xrandr for my TV and PC monitor.
	local monitor_id="DVI-D-0"
	local tv_id="HDMI-0"

	# Commands
	xrandr --output $tv_id --same-as $monitor_id	# Set TV (hdmi) to be the same as main monitor
	picom &						# Picom for transparency
	mpd &						# music player daemon
	ums &						# Start Universal Media Server
	#mpDris2 &					# control mpd with playerctl
	setxkbmap -option caps:escape			# Set caps lock to escape
	lxsession &					# Start policy kit
	numlockx on					# Turn on the numlock
	clipmenud &					# Clipmenu
	nitrogen --restore				# Restore wallpaper
	xset s 900					# Blankout screen after 15 minutes
	redshift-gtk &					# Redshift for bluelight filter
	playerctld daemon &				# Start playerctl daemon, tracks recent media players
}

# Run the shared settings first.
shared_settings

# Switch to determine which window manager we want to execute.
case $session in
	awesome|awm	) awesome;;
	dwm		) dwm;;
	gnome		) gnome;;
	plasma|kde	) plasma;;
	*		) echo "Session not found." && exit 1
esac
