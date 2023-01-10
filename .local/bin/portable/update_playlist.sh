#!/usr/bin/bash

# Script to update a YouTube Playlist.

# URL of the playlist to keep updated.
playlist_url=""

# Name of playlist file.
playlist_name=""

# Resolution to get
resolution="1080"

# Formatting for video output
output_format="%(playlist_index)s - %(title)s.%(ext)s"

# Playlist file for UMS
playlist_file="$HOME/Videos/playlists/$playlist_name.m3u"

# Archive file to track downloaded episodes.
archive_file="./archive.txt"

# Call to yt-dlp
yt-dlp \
	--paths "./" \
	--output "$output_format" \
	--format "bestvideo[height<=$resolution][ext=webm]+bestaudio" \
	--embed-subs \
	--embed-thumbnail \
	--add-metadata \
	--download-archive "$archive_file" \
	--sponsorblock-remove sponsor \
	--merge-output-format mkv \
	"$playlist_url"

# Remove old playlist if it exists.
if [ -f "$playlist_file" ]; then
	rm $playlist_file
	echo "#EXTM3U" > $playlist_file
fi

# Create a m3u playlist for UMS and mpv
for file in ./*.mkv; do
	echo $file >> $playlist_file
done
