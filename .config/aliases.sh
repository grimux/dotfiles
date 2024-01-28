###############
### Aliases ###
###############

########################
### Global variables ###
########################
export yt_app="yt-dlp --config-location"
export yt_config_location="~/.config/youtube-dl"
export video_playlist_dir="/mnt/v/playlists"
export mpv_playlist_settings="--loop-playlist --save-position-on-quit"

## ls/lsd, grep ##
#alias ls="ls --color=auto --group-directories-first"
#alias la="ls -lA --color=auto --group-directories-first"
alias ls="lsd -1 --group-directories-first"
alias la="lsd --almost-all --long --group-directories-first"
alias lu="lsd --sizesort --almost-all --total-size --long --group-directories-first"
alias lss="/usr/bin/ls -1 --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias searchtext="grep -R --color=auto"
alias dir_size="du -d 1 -h | sort -h"

## Config files ##
alias cfa="$EDITOR ~/.config/aliases.sh"
alias cfv="$EDITOR ~/.config/nvim/init.vim"
alias cfx="$EDITOR ~/.xinitrc"
alias cfz="$EDITOR ~/.zshrc"
alias cfb="$EDITOR ~/Videos/playlists/bedtime.m3u"
alias cfs="$EDITOR ~/.config/script_boilerplate.sh"
alias cfawe="$EDITOR ~/.config/awesome/rc.lua"
alias cfd="$EDITOR ~/.config/gzdoom/mod_profiles.sh"

alias gift-list="nvim -c \"VimwikiIndex\" -c \"VimwikiGoto personal/gift-list\""
alias cfbn="nvim -c \"VimwikiIndex\" -c \"VimwikiGoto notes/behavioral_notes\""

## Program shortcuts ##
alias define="sdcv"			# Dictionary
#alias copy="xclip -rmlastnl -selection clipboard"
alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -out"
alias f="ranger"
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
alias movies="ranger ~/Videos/movies"
alias videos="ranger ~/Videos/playlists"
alias fluffy="cd /mnt/s/modding/Fluffy_Mod_Manager; wine /mnt/s/modding/Fluffy_Mod_Manager/Modmanager.exe"
alias autoremove="pacman -Qtdq | sudo pacman -Rns -"
alias 7z_update="7z u -up1q0r2x1y2z1w2 -mx9 -mmt16"

## Dotfile alias ##
# An alias to manage my dotfiles.
alias config="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"
alias cstat="clear; config status"
alias cdiff="config diff; clear"

## yt-dlp ##
alias yta="$yt_app $yt_config_location/audio_single"
alias ytap="$yt_app $yt_config_location/audio_playlist"
alias ytas="$yt_app $yt_config_location/audio_split"
alias ytpod="$yt_app $yt_config_location/podcast"
alias ytv="$yt_app $yt_config_location/video_single"
alias ytvp="$yt_app $yt_config_location/video_playlist"
alias ytu="$yt_app $yt_config_location/video_single --batch-file $HOME/urls.txt && echo \"\" > $HOME/urls.txt"

# Copy game files using rsync
alias send_game="rsync -hvrlt --info=progress2 --stats"
alias copy_files="rsync -rvhtU --info=progress2 --stats"

## Games ##
#alias im_stuck="steam -applaunch 1010750 map e1m1"
alias im_stuck="nblood"
alias help_me="nblood"
alias play_blood="lutris lutris:rungameid/60"
alias jkdf2="openjkdf2"
alias perfect-dark="lutris lutris:rungameid/252"
alias oot="lutris lutris:rungameid/61"

## Music ##
alias dangan="mpc clear; mpc searchadd Title \"Into Free\"; mpc play; lyrics"
alias meditation="mpv /mnt/s/music/meditation/jon_kabat_meditation.mp3"
alias playback="mpc clear; mpc searchadd Artist \"Forth Right MC\"; mpc play"

## Video Playlists ##
alias factorio="mpv $mpv_playlist_settings $video_playlist_dir/factorio_1.0_tuplex.m3u"
alias futurama="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/futurama.m3u"
alias subnautica="mpv $mpv_playlist_settings $video_playlist_dir/subnautica.m3u"
alias spongebob="mpv $mpv_playlist_settings --shuffle $video_playlist_dir/spongebob.m3u"
alias blood="mpv $mpv_playlist_settings $video_playlist_dir/blood_fresh_supply.m3u"
alias xavier="mpv $mpv_playlist_settings $video_playlist_dir/xavier.m3u"
alias xfiles="mpv $mpv_playlist_settings $video_playlist_dir/xfiles.m3u"
alias twinpeaks="mpv $mpv_playlist_settings $video_playlist_dir/twin_peaks.m3u"

## Helpful ##
alias calm="mpv --loop --fullscreen /mnt/v/relaxing/Autism_Calming_Sensory_Meltdown_Remedy_Soothing_Visuals-Super_Duper_Fun_Music.mkv"

## Directories ##
alias gc="cd /mnt/x/game-stuff/game-collection"
alias steamdir="cd $HOME/.steam/steam"
alias bin="cd $HOME/.local/bin"
alias wallpaper="ranger $HOME/Pictures/game-screenshots"

## Information ##
alias list-fonts="fc-list : family | sort | uniq"
