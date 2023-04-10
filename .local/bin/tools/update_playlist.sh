#!/usr/bin/bash
#
# Script to update a YouTube Playlist.
#
# TODO:
# - Migrate from testing branch to main.
#
### Script Fail Events ###
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
#set -euox pipefail
set -euo pipefail


########################
### Sourcing Configs ###
########################
#
# This script will source the provided config file.  These variables can be overridden here to apply global
# settings.
# 
playlist_name=""
channel_name=""
playlist_url=""
resolution="1080"
playlist_directory=""
m3u_file=""
archive_file=""
randomized_m3u=""


##############
### Config ###
##############
# yt-dlp config path
yt_config="$HOME/.config/youtube-dl"

# Directory containing all playlist configs.
playlist_config_directory="$yt_config/playlist_configs"

# Playlist ouput directory
video_directory="$HOME/Videos"

# Directory to store m3u playlists.
m3u_directory="$video_directory/playlists"

# Directory to store the archive files.  Used to track download history of a playlist.
archive_directory="$yt_config/archives"

# Output format for the video's filename.
output_format="%(playlist_index)s-%(title)s.%(ext)s"

# Format settings to select the resolution that we want
#format_settings="bestvideo[height<=$resolution][ext=webm]+bestaudio"
format_settings="bestvideo[height<=$resolution]+bestaudio"


######################
### Initialization ###
######################
# If not found, tell us and exit 1.
if [ ! -d "$playlist_config_directory" ]; then
	echo "Error!  Playlist config directory not found!"
	echo "Should be here: $playlist_config_directory"
	exit 1
fi

# Create a varible to contain the argument passed to the script.  If no argument is supplied, the variable
# is set to "null".
chosen_config=${1:-null}


#################
### Functions ###
#################
# List the config avalible
function list_configs() {
	ls -A1 "$playlist_config_directory"
}

function check_playlist() {
	local playlist="$1"

	if [ -f "$playlist_config_directory/$playlist" ]; then
		echo "Playlist config found: $playlist"
		source "$playlist_config_directory/$playlist"
	else
		echo "Config not found: $playlist"
		exit 1
	fi
}

# Function to download the playlist, using yt-dlp.
function download_playlist() {
	# Call to yt-dlp
	yt-dlp \
		--paths "$video_directory/$playlist_directory" \
		--output "$output_format" \
		--format "$format_settings" \
		--embed-subs \
		--embed-thumbnail \
		--add-metadata \
		--download-archive "$archive_directory/$archive_file" \
		--sponsorblock-remove sponsor \
		--restrict-filenames \
		--merge-output-format mkv \
		"$playlist_url"
}

# Create an m3u playlist.
function create_m3u() {
	local m3u_file_path="$m3u_directory/$m3u_file"
	echo "Creating playlist for:  \"$(basename "$m3u_file_path")\""

	# Remove old playlist if it exists.
	if [ -f "$m3u_file_path" ]; then
		rm "$m3u_file_path"
	fi

	# Create an m3u playlist.
	for file in $video_directory/$playlist_directory/*.mkv; do
		readlink --canonicalize "$file" >> "$m3u_file_path"
	done

	if [ "$randomized_m3u" -eq 1 ]; then
		echo "Random mode: ON"
		shuf --output="$m3u_file_path" "$m3u_file_path"
	fi

	# Begin the new playlist file with the required file header (needed for UMS).
	echo "#EXTM3U" | cat - "$m3u_file_path" > temp && mv temp "$m3u_file_path"

	# Print out the playlist file for verification.
	echo "Contents of m3u file:"
	cat "$m3u_file_path"

}

# Get script arguments.
function get_arguments() {
	while getopts ":dp:rl" option; do
		case $option in
			r) randomized_m3u=1;;
			d) download_playlist; exit;;
			c) create_m3u; exit;;
			p) chosen_config=${OPTARG};;
			l) list_configs; exit;;
			/?) echo "Invalid option."; exit 1;;
		esac
	done
}


############
### Main ###
############
function main() {
	get_arguments "$@"


	download_playlist && echo "Downloading complete!"

	create_m3u && echo "Playlist created!"

	echo "All done."
}

function main_testing() {
	echo "Testing branch"

	get_arguments "$@"

	check_playlist "$chosen_config"

	(download_playlist && echo "Downloading complete!") || exit 1

	create_m3u && echo "Playlist created!"
}
# Call to main.
#main "$@"
main_testing "$@"
