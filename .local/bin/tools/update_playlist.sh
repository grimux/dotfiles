#!/usr/bin/bash
#
# Script to update a YouTube Playlist.
#
# e - script stops on error
# u - error if undefined variable
# o pipefail - script fails if command piped fails
# x - output each line (debug)
#
set -euox pipefail
#set -euo pipefail

##############
### Config ###
##############
# Title of playlist.
playlist_name=""

# URL of the playlist to keep updated.
playlist_url=""

# Default resolution to download.
resolution="1080"

# Playlist file for UMS and mpv
m3u_directory="$HOME/Videos/playlists"
m3u_file="whatever.m3u"

# Archive location and file.  Used to track download history.
archive_directory="$HOME/.config/youtube-dl/archives"
archive_file="whatever.archive"

# Ramdomized m3u playlist
randomized_m3u=0

# Formatting for video file name.
output_format="%(playlist_index)s - %(title)s.%(ext)s"
format_settings="bestvideo[height<=$resolution][ext=webm]+bestaudio"



#################
### Functions ###
#################
# Function to download the playlist, using yt-dlp.
download_playlist() {
	# Call to yt-dlp
	yt-dlp \
		--paths "./" \
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
create_m3u() {
	local m3u_file_path="$m3u_directory/$m3u_file"
	echo "Creating playlist for:  \"$(basename "$m3u_file_path")\""

	# Remove old playlist if it exists.
	if [ -f "$m3u_file_path" ]; then
		rm "$m3u_file_path"
	fi
	
	# Create an m3u playlist.
	for file in ./*.mkv; do
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
get_arguments() {
	while getopts ":dpr" option; do
		case $option in
			r)
				randomized_m3u=1
				;;
			d)
				download_playlist
				exit
				;;
			p)
				create_m3u
				exit
				;;
			/?)
				echo "Invalid option."
				exit 1
		esac
	done
}




############
### Main ###
############
main() {
	get_arguments "$@"

	download_playlist && echo "Downloading complete!"

	create_m3u && echo "Playlist created!"

	echo "All done."
}

# Call to main.
main "$@"
