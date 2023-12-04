#!/usr/bin/env bash
#
# A script to install vim-plug.
#
###################
### Fail Events ###
###################
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
#set -euox pipefail
set -euo pipefail

# Plugin website.
vimplug_website="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# Plugin file location
vimplug_location="$HOME/.local/share/nvim/site/autoload/plug.vim"

# Yes or no.
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

# Check to see if vim-plug is already installed.
function check_install() {
	local install_location="$1"
	local exists=0

	if [ -f "$install_location" ]; then
		exists=1
	fi

	echo "$exists"
}

# Install vim-plug.
function install_vimplug() {
	echo "Installing vim-plug..."
	curl \
		--fail \
		--location \
		--output "$vimplug" \
		--create-dirs \
		"$vimplug_website"
}

# Install all vim-plug plugins.
function install_plugins() {
	nvim -c PlugInstall -c quitall
}

# Upgrade and update plugins.
function update_plugins() {
	echo "Checking for updates..."
	nvim -c PlugUpgrade -c PlugUpdate -c quitall
}

# Main function.
function main() {
	local is_vimplug_installed

	# Variable for if vim-plug is installed or not.
	# 1 yes, 0 no.
	is_vimplug_installed=$(check_install "$vimplug_location")

	# Main logic.
	# If vim-plug is installed.
	if [ "$is_vimplug_installed" -eq 1 ]; then
		# Console output.
		echo "vim-plug is already installed."
		# Show info on the file using ls.
		echo "Info: $(ls -la $vimplug_location)"
		# Prompt for updates, if yes then run the update_plugins function.
		yes_or_no "Would you like to check for updates?" && update_plugins

	# If vim-plug is not installed.
	else
		# Install vim-plug.
		install_vimplug
	fi

	# All finished.
	echo "All done."
}

# Call to main
main
