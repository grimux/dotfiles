#!/usr/bin/env bash
#
####################
#
# Name:
# Author:
# Description:
#
####################


############
### TODO ###
############
#
# - Add more comments.
#
############


###################
### Fail Events ###
###################
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
# These events can be removed and readded to the script at any point.
# Ex: "set +e" to remove auto exit on error, "set -e" to add it back.
#
set -euox pipefail
#set -euo pipefail
#
###################


########################
### Sourced Settings ###
#########################################################################################
#
# All the variables and settings used for this script.  Sourced from Config File.
#

#########################################################################################



##############
### Config ###
##############
#


##########################
### Source Config File ###
#########################################################################################
#
# The variable "SCRIPT_CONFIG" is exported by the shell.  It contains various settings
# for our scripts.
#
# Check if the script config file exists, if so source it.  Otherwise exit with error.
if [ ! -f "$SCRIPT_CONFIG" ]; then
	echo "The configuration script is missing!"
	echo "Should be at: \"HOME/.config/script_config.sh\"."
	exit 1
else
	source "$SCRIPT_CONFIG"
fi
#
#########################################################################################


######################
### Initialization ###
######################
#


##################################
### Arguments, Help, and Usage ###
##################################
#
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
	echo "Syntax: $(basename $0) (options) <arguments>"
	echo "options:"
	# Space offset: 19
	echo "h                   : Print this help screen."
	echo
	echo "arguments:"
	echo "d                   : Example."
}

# How to use the script.
function usage() {
	echo "$(basename $0) (options)"
}


#################
### Functions ###
#################
#


#########################
### Testing Functions ###
#########################
#



###############
### Testing ###
###############
#
function testing() {
	local some_variable
}


############
### Main ###
############
#
function main() {
	local some_variable
}


#############
### Start ###
#############
#testing "$@"
main "$@"
