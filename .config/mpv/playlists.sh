#############################
### mpv Playlist Profiles ###
#############################
#
# Playlist profiles for dynamic creation.  The arrays represent the directories
# that the script will search and add videos from.  This way, these playlists
# are dynamic and can be generated very quickly.
#

### Playlist Profiles ###
# An array of playlist profile names.
declare playlist_profiles=(
	games
	game_reviews
	gdq_speedruns
)

# All game videos.  Like a video game channel.
declare games=(
	documentary
	dykg
	essays
	gdq_speedruns
	misc
	reviews
)

# Essays and reviews.
declare game_reviews=(
	essays
	reviews
)

# GDQ Speedruns.
declare gdq_speedruns=(
	gdq_speedruns
)
