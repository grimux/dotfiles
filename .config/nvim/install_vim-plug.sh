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
function install_vimplug(){
	curl \
		--fail \
		--location \
		--output "$vimplug" \
		--create-dirs \
		"$vimplug_website"
}

# Main function.
function main() {
	local is_vimplug_installed

	is_vimplug_installed=$(check_install "$vimplug_location")

	if [ "$is_vimplug_installed" -eq 1 ]; then
		echo "vim-plug is already installed."
		echo "Info: $(ls -la $vimplug_location)"
		echo "Aborting..."
		exit
	else
		echo "Installing vim-plug..."
	fi
}

main
