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
	game_chill
	to_watch
)

# All game videos.  Like a video game channel.
declare games=(
	games/documentary
	games/dykg
	games/essays
	games/gdq_speedruns
	games/misc
	games/reviews
)

# Essays and reviews.
declare game_reviews=(
	games/essays
	games/reviews
)

# GDQ Speedruns.
declare gdq_speedruns=(
	games/gdq_speedruns
)

# Relaxing game videos.
declare game_chill=(
	dykg
	gdq_speedruns
)

# Downloaded videos not yet watched or organized.
declare to_watch=(
	yt-dlp
)
