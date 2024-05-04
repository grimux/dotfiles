#!/usr/bin/env bash
#
# xinit script
#
# by: Jake "grimux"
#

# Set awesome as the default, otherwise the argument passed will be the session.
session=${1:-awesome}

# AwesomeWM config
function awesome() {
	# Picom for transparency
	picom &

	# Start policy kit
	lxsession &

	# Restore wallpaper using Nitrogen
	#nitrogen --restore &

	# Restore wallpaper using feh
	~/.fehbg &

	# Run custom signals for awesome/lain status bar
	~/.config/awesome/custom_signals.sh &

	# Redshift for bluelight filter
	# Use either the gtk tray icon or not.  Use `redshift -p` to check status.
	redshift-gtk &
	#redshift &

	# Fix for steam
	#/usr/lib/xdg-desktop-portal-gtk &
	#/usr/lib/xdg-desktop-portal-lxqt &
	#/usr/lib/xdg-desktop-portal &

	export XDG_SESSION_TYPE='x11'

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

# General settings shared by all configs.
function shared_settings() {
	# ID names from xrandr for my TV and PC monitor.
	local monitor_id="DVI-D-0"
	local tv_id="HDMI-0"

	# Set TV (hdmi) to be the same as main monitor
	xrandr --output $tv_id --same-as $monitor_id &

	# music player daemon
	# Check if the pid file exists, if not, start mpd.
	# If file exists and size greater than zero (-s), skip.
	[ ! -s ~/.local/share/mpd/pid ] && mpd

	# Start Universal Media Server
	ums &

	# OpenRGB for PC's RGB lighting.
	#openrgb --server --profile Rainbow.orp --startminimized &
	openrgb --server --profile default_profile --startminimized &

	# control mpd with playerctl
	#mpDris2 &

	# Set caps lock to escape
	#setxkbmap -option caps:escape &

	# Turn on the numlock
	numlockx on &

	# Clipmen daemon
	clipmenud &

	# Blankout screen after 15 minutes
	xset s 900 &
	xset dpms 900 900 900 &

	# Start playerctl daemon, tracks recent media players and can control them with media keys.
	playerctld daemon &
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
