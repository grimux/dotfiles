###############
### Aliases ###
###############

########################
### Global variables ###
########################
################################################################
################################################################


####################
### ls/lsd, grep ###
####################
#
################################################################
#
#alias ls="ls --color=auto --group-directories-first"
#alias la="ls -lA --color=auto --group-directories-first"
alias ls="lsd -1 --group-directories-first"
alias la="lsd --almost-all --long --group-directories-first"
alias lu="lsd --sizesort --almost-all --total-size --long --group-directories-first"
alias lss="/usr/bin/ls -1 --color=auto --group-directories-first"
alias grep="grep --color=auto"
#
################################################################


####################
### Config files ###
####################
#
################################################################
#
alias cfa="$EDITOR ~/.config/aliases.sh"
alias cfv="$EDITOR ~/.config/nvim/init.vim"
alias cfx="$EDITOR ~/.xinitrc"
alias cfz="$EDITOR ~/.config/zsh/.zshrc"
alias cfb="$EDITOR ~/Videos/playlists/bedtime.m3u"
alias cfs="$EDITOR ~/.config/script_boilerplate.sh"
alias cfawe="$EDITOR ~/.config/awesome/rc.lua"
alias cfawet="$EDITOR ~/.config/awesome/theme.lua"
alias cfd="$EDITOR ~/.config/gzdoom/mod_profiles.sh"
alias cfpac="$EDITOR /etc/pacman.conf"
alias boiler="$EDITOR ~/.config/script_boilerplate.sh"
#
################################################################


##############################
### Vimwiki Page Shortcuts ###
##############################
#
################################################################
#
# New Method
# neovim automatically knows that markdown files in the `vimwiki` directory should be used with the
# `vimwiki` plugin, so all the `vimwiki` functionality should be loaded and avalible.  Use `:VimwikiIndex`
# to access the home page.
vimwiki_dir="$HOME/vimwiki"
alias vw-gl="$EDITOR $vimwiki_dir/personal/gift-list.md"
alias vw-bn="$EDITOR $vimwiki_dir/notes/behavioral_notes.md"
alias vw-tn="$EDITOR $vimwiki_dir/personal/health-mental/therapy/trauma-notes.md"
alias vw-si="$EDITOR $vimwiki_dir/writing/script-ideas.md"
alias vw-ct="$EDITOR $vimwiki_dir/writing/computer-todo.md"
alias vw-gt="$EDITOR $vimwiki_dir/writing/general-todo.md"
alias vw-st="$EDITOR $vimwiki_dir/writing/script-todo.md"
alias diary="vimwiki diary"

# Alternative names
alias todo-comp=""
alias todo-gen=""
alias todo-script="$EDITOR $vimwiki_dir/writing/script-todo.md"
#
# Old Method
#
#alias vwgl="nvim -c \"VimwikiIndex\" -c \"VimwikiGoto personal/gift-list\""
#alias vwbn="nvim -c \"VimwikiIndex\" -c \"VimwikiGoto notes/behavioral_notes\""
#alias vwtn="nvim -c \"VimwikiIndex\" -c \"VimwikiGoto personal/health-mental/therapy/emdr-notes\""
#
################################################################


#######################
## Program shortcuts ##
#######################
#
################################################################
alias bulkrename="brn"
alias define="sdcv"			# Dictionary
#alias copy="xclip -rmlastnl -selection clipboard"
alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -out"
alias f="ranger"
alias fterm="f"
alias fterm2="yazi"
alias ka="killall"
alias ncm="ncmpcpp"			# Terminal music player for mpd
alias pt="protontricks"
alias py="python"
alias sdn="shutdown now"
alias sf="sudo ranger"			# Run ranger as root
alias spell="look"
alias tar-backup="tar cvfpz"
alias tar-restore="tar xvfpz"
alias trem="transmission-remote"
alias vimhelp="nvim -c help -c only"	# Open the help section of nvim
alias vim="nvim"
alias weather="curl wttr.in"		# Get the current weather
alias x="exit"
alias rsync-fat="rsync -hvrltD --modify-window=1 --stats --info=progress2"
alias mountsd="sudo mount /dev/sdf1"
alias mnt-steamdeck="sudo mount -L steam-deck /mnt/steamdeck"
alias movies="ranger ~/Videos/movies"
alias videos="ranger ~/Videos/playlists"
alias fluffy="cd /mnt/s/modding/Fluffy_Mod_Manager; wine /mnt/s/modding/Fluffy_Mod_Manager/Modmanager.exe"
alias autoremove="pacman -Qtdq | sudo pacman -Rns -"
alias 7z_update="7z u -up1q0r2x1y2z1w2 -mx9 -mmt16"
alias yayrm="yay -Rscn"
alias pacrm="sudo pacman -Rscn"
alias test-mpv="mpv --input-test --force-window --idle"
alias git-add-untracked="echo -e \"a\n*\nq\n\" | git add -i"
alias sysctl="systemctl --user"
#
################################################################


###################
## Dotfile alias ##
###################
#
################################################################
#
# An alias to manage my dotfiles.
alias config="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"
alias cstat="clear; config status"
alias cdiff="config diff; clear"
alias cadd="config add"
alias ccommit="config commit; clear"
#
################################################################


##############
### yt-dlp ###
##############
#
################################################################
#
# Configs
yt_config_location="~/.config/youtube-dl"
yt_to_download_file="$yt_config_location/to-download.txt"
#
# Variable shortcuts.
yt_app="yt-dlp"
yt_app_config="--config-location $yt_config_location"
yt_call="$yt_app $yt_app_config"
#
# Commands
alias yta="$yt_call/audio_single"
alias ytap="$yt_call/audio_playlist"
alias ytas="$yt_call/audio_split"
alias ytpod="$yt_call/podcast"
alias ytv="$yt_call/video_single"
alias ytvp="$yt_call/video_playlist"
alias ytu="$yt_call/video_single --batch-file $yt_to_download_file && rm $yt_to_download_file"
alias ytua="echo $1 >> $yt_to_download_file"
#
################################################################


#############
### rsync ###
#############
#
# Copy game files using rsync
#
alias send_game="rsync -hvrlt --inplace --info=progress2 --stats"
#alias copy_files="rsync -rvhtU --info=progress2 --stats"
alias copy_files="rsync --archive --human-readable --verbose --info=progress2 --stats"
#
################################################################


#############
### Games ###
#############
#
###############################################################
#
#alias im_stuck="steam -applaunch 1010750 map e1m1"
alias im_stuck="lutris lutris:rungameid/27"
alias help_me="lutris lutris:rungameid/27"
alias blood="lutris lutris:rungameid/27"
alias cultic="steam_launcher 1684930"
alias factorio="steam_launcher 427520"
alias jkdf2="openjkdf2"
alias pd="lutris lutris:rungameid/252"
alias grim="steam_launcher 219990"
alias perfect-dark="lutris lutris:rungameid/252"
alias zelda-oot="lutris lutris:rungameid/61"
alias zelda-mm="lutris lutris:rungameid/265"
#
################################################################



#############
### Music ###
#############
#
###############################################################
#
alias m-dangan="mpc clear; mpc searchadd Title \"Into Free\"; mpc play; lyrics"
alias m-meditation="mpv /mnt/s/music/meditation/jon_kabat_meditation.mp3"
alias m-playbackfm="mpc clear; mpc searchadd Artist \"Forth Right MC\"; mpc repeat 1; mpc play"
alias m-isolated="mpc clear; mpc searchadd Album \"Disorder\" Title \"Isolated\"; mpc repeat 1; mpc play"
alias m-n64-chill="mpv \"/mnt/v/music-videos/game-compilations/Relaxing Video Game Music (N64 Edition).mkv\""
alias m-ps1-chill="mpv \"/home/jake/Videos/music-videos/game-compilations/PlayStation 1 Music - Relaxing Video Game Music for Studying.mkv\""
alias m-mask="mpc clear; mpc searchadd Title \"Beneath the Mask\" Track \"29\"; mpc play; lyrics"
#
################################################################


#####################
## Video Playlists ##
#####################
#
################################################################
#
video_playlist_dir="/mnt/v/playlists"
mpv_playlist_settings="--loop-playlist --save-position-on-quit"
#alias factorio="mpv $mpv_playlist_settings $video_playlist_dir/factorio_1.0_tuplex.m3u"
alias v-futurama="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/futurama.m3u"
#alias subnautica="mpv $mpv_playlist_settings $video_playlist_dir/subnautica.m3u"
alias v-spongebob="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/spongebob.m3u"
#alias blood="mpv $mpv_playlist_settings $video_playlist_dir/blood_fresh_supply.m3u"
alias v-xavier="mpv $mpv_playlist_settings $video_playlist_dir/xavier.m3u"
alias v-xfiles="mpv $mpv_playlist_settings $video_playlist_dir/xfiles.m3u"
alias v-twinpeaks="mpv $mpv_playlist_settings $video_playlist_dir/twin_peaks.m3u"
#
################################################################


###############
### Helpful ###
###############
#
################################################################
#
alias calm1="mpc pause; mpv --loop --fullscreen \"/mnt/v/relaxing/Autism_Calming_Sensory_Meltdown_Remedy_Soothing_Visuals-Super_Duper_Fun_Music.mkv\""
alias calm2="mpc pause; mpv --loop --fullscreen \"/home/jake/Videos/relaxing/Autism Sensory Therapy Magic Meltdown Remedy™ Second Edition by SAND.mkv\""
alias hl2-amb="mpc pause; mpv --loop --fullscreen --playlist=/mnt/v/playlists/hl2.m3u"
alias emdr="mpc pause; mpv --loop --fullscreen --mute --start=10 --ab-loop-a=10 --ab-loop-b=611 \"/home/jake/Videos/health/isochronicalpha - EMDR Self Administered with 528Hz Harmonics.mkv\""
#
################################################################


###################
### Directories ###
###################
#
################################################################
#
alias gc="cd /mnt/x/game-stuff/game-collection"
alias steamdir="cd $HOME/.steam/steam"
alias bin="cd $HOME/.local/bin"
alias wallpaper="ranger $HOME/Pictures/game-screenshots"
#
################################################################


###################
### Information ###
###################
#
################################################################
#
alias list-fonts="fc-list : family | sort | uniq"
alias searchtext="grep -R --color=auto"
alias dir-size="ls-dir"
#
################################################################
