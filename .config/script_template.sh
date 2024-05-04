#!/usr/bin/env bash
#
#
#

###################
### Fail Events ###
###################
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
set -euox pipefail
#set -euo pipefail

# Get arguments and set flags
function get_arguments() {
	while getopts ":h" option; do
		case $option in
			# What to do if there is an invalid argument.
			\?) echo "Error: Invalid option"; exit 1 ;;

			# Help section
			h) help_section; exit ;;

			# What to do if the argument is missing.
			:) echo "Missing argument"; help_section; exit 1 ;;

			# Catchall.  If command is not recognized.
			*) usage; exit 1
		esac
	done
}

# Help Section
function help_section() {
	echo "A short description of script"
	echo
	echo "Syntax: $(basename $0) (options) [-n] <playlist name> [-d] <video directory>"
	echo "options:"
	# Space offset: 19
	echo "h                   : Print this help screen."
	echo "r <playlist name>   : Remove playlist."
	echo "a                   : Append to playlist."
	echo
	echo "arguments:"
	echo "n                   : Name of the playlist to create (m3u)."
	echo "d                   : Directory of video files (mkv)."
}

