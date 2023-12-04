#
# A script/config file that contains my favorite/most often used code.
#

### Shebang ###
#!/usr/bin/env bash

####################################################################################################
# Fail Events:
####################################################################################################
#
# This section will control fail and debug events in the script.  This should be added to every
# script to help ensure unexpected events due to bugs.  There are some cases (rare) where this
# should not be used.
#
# Only choose one option below and comment out the other.
#
# The `x` flag is very useful when debugging.
#---------------------------------------------------------------------------------------------------

###################
### Fail Events ###
###################
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
set -euox pipefail
set -euo pipefail





####################################################################################################
# Getting arguments:
####################################################################################################
#
# A function to get arguments passed to the script.  Adjust the options to suit your needs.
# The `:` character denotes that an argument is expected.  The argument will be set to `${OPTARG}`.
#
# Add additional flags to `getopts` and add a section to the case statement to control logic.
#
#---------------------------------------------------------------------------------------------------

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





####################################################################################################
# The Help Section
####################################################################################################
#
# A function to display a help menu that shows avalible options.  `$(basename $0)` is the name of
# the script.
#
# It's best to use spaces to line everything up, as opposed to tabs.
#
# Example text shown.  Change to suit your script.
#
#---------------------------------------------------------------------------------------------------

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





####################################################################################################
# Script Usage:
####################################################################################################
#
# A function to show usage instructions for the script.  `$(basename $0)` is the name of the
# script.
#
# Example text shown.  Change to suit your script.
#
#---------------------------------------------------------------------------------------------------

# How to use the script.
function usage() {
	echo "$(basename $0) (options) [-n] <name> [-d] <directory>"
}


####################################################################################################
# Headers and Footers
####################################################################################################
#
# Some functions to provide nice headers and footers with custom text.
#

### header
#
# A nice header for information.  Pass in some text to display it.
#
function header() {
	local text="$1"

	echo "================================================"
	echo "$text"
	echo "------------------------------------------------"
}

### footer
#
# A footer to use after certain code execution to provide a nice "block" of info.
# Use below a header obviously.
#
function footer() {
	echo "================================================"
	echo
}



####################################################################################################
# Continue prompt
####################################################################################################
#
# A function to prompt before proceeding with something.  There are two parts to using this, the
# function (Part A) and the variable (Part B).
#
# The function will use logic (and loops) to return either 1 for yes or
# 0 for no.
#
# The variable is assigned to the function elsewhere in the script and additional logic is
# used to determine what to do; based on yes or no.
#
# Example text shown.  Change to suit your script.
#
#---------------------------------------------------------------------------------------------------

#=========
# Option 1
#=========

#--------
# Part A
#--------

# Prompt to proceed
proceed_prompt() {
	# While loop to get user input
	# Prompt for input, to delete or not
	valid=0
	while (( ! valid )); do
		read -p "Do you want to proceed? (y/n): "
		case $REPLY in
			y) valid=1; echo 1;;
			n) valid=1; echo 0;;
		esac
	done
}

#--------
# Part B
#--------

# Prompt to continue
local to_continue=$(proceed_prompt)

# If $to_continue is 0,
if [ "$to_continue" -eq 0 ]; then
	echo "Skipping zip extraction."
	echo
	return
fi


#==========
# Yes or No
#==========

#-------
# Part A
#-------
# A simple function to return results based on a yes or no statement.
# Notice the logic is reversed when returning integers as opposed to
# echoing them.  Return 0 is success, return 1 is failure.
function yes_or_no() {
	local choice
	local prompt="$1"

	while true; do
		read -p "$prompt (y/n): " choice
		case $choice in
			[Yy]*) return 0;;
			[Nn]*) return 1;;
		esac
	done
}


#-------
# Part B
#-------
# Call to Part A, using comparison operator.
yes_or_no "Would you like to continue?" || exit

# Or using an `if` block
if yes_or_no "Would you like to continue?"; then
	echo "Continuing."
else
	echo "Stopping."
fi


