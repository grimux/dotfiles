################################
### Doom Script Mod Profiles ###
################################

# A function with a simple case statement.  The statement will set the variables for the arguments that will
# eventually be passed to gzdoom.  The variables here are global and can be accessed from elsewhere in the 
# script.  Just call this function and pass along the name of the mod.
function mod_profiles() {
	# First argument passed is called mod_name.
	local mod_name="$1"

	# Switch case to choose the settings.
	case "$mod_name" in
	
		## Mod Settings ##

		# Chill Doom
		chill_doom)
			iwad=DOOM.WAD
			wads="SmoothDoom.pk3 DoomMetalVol5.wad"
			maps="+map e1m1"
			savedir="$savedir/chill_doom"
			cheats="+buddha2 +give keys"
			skill="+skill 3"
			;;
	
		# Brutal Minecraft
		brutal_minecraft)
			iwad=DOOM2.WAD
			wads="\
				brutal_minecraft/BM_MAIN_v1.0.pk3 \
				brutal_minecraft/BM_RES_v1.0.pk3  \
				brutal_minecraft/BM_RES2_v1.0.pk3 \
				brutal_minecraft/BM_MAP_v1.0.wad \
				brutal_minecraft/BM_ElectricPlayer_v1.0.pk3 \
				brutal_minecraft/BM_Inventory_v1.0.pk3 \
				brutal_minecraft/TiltPlusPlus_v1.65.pk3"
			maps=""
			savedir="$savedir/brutal_minecraft"
			cheats=""
			skill=""
			;;
	
		elementalism)
			iwad=DOOM2.WAD
			wads="Elementalism_Phase1_RC1_1.01.pk3"
			maps=""
			savedir="$savedir/elementalism"
			cheats=""
			skill=""
			;;
	
		golden_souls)
			iwad=DOOM.WAD
			wads="GoldenSouls_Full_1.4.pk3"
			maps=""
			savedir="$savedir/golden_souls"
			cheats=""
			skill=""
			;;
	
		guncaster)
			iwad=DOOM2.WAD
			wads="Guncaster.pk3"
			maps=""
			savedir="$savedir/guncaster"
			cheats=""
			skill=""
			;;
	
		h_doom)
			iwad=DOOM2.WAD
			wads="m12-hdoom_techdemo9.pk3"
			maps=""
			savedir="$savedir/h_doom"
			cheats=""
			skill=""
			;;
	
		hedon)
			iwad=DOOM2.WAD
			wads="Hedon.ipk3 ThiccEdition.pk3"
			maps=""
			savedir="$savedir/hedon"
			cheats=""
			skill=""
			;;
	
		mower)
			iwad=DOOM2.WAD
			wads="doom_mower_v2.wad"
			maps=""
			savedir="$savedir/doom_mower"
			cheats=""
			skill=""
			;;
	
		project_brutality)
			iwad=DOOM2.WAD
			wads="\
				Project_Brutality.pk3 \
				pb_hud_base_a.pk3 \
				pb_hud_base_b.pk3"
			maps=""
			savedir="$savedir/project_brutality"
			cheats=""
			skill=""
			;;
	
		reelism2)
			iwad=DOOM2.WAD
			wads="reelism2_v1.23.pk3"
			maps=""
			savedir="$savedir/reelism2"
			cheats=""
			skill=""
			;;
	
		russian_overkill)
			iwad=DOOM2.WAD
			wads="RO.pk3"
			maps=""
			savedir="$savedir/russian_overkill"
			cheats=""
			skill=""
			;;
	
		siren)
			iwad=DOOM2.WAD
			wads="Siren-0.6a.pk3"
			maps=""
			savedir="$savedir/siren"
			cheats=""
			skill=""
			;;
	
		spooktober)
			iwad=DOOM2.WAD
			wads="SmoothDoom.pk3 spooktober.pk3 STEVE_FLASHLIGHT_PLUS.PK7"
			maps=""
			savedir="$savedir/spooktober"
			cheats=""
			skill=""
			;;
	
		*)
			echo "Invalid mod"
			exit 1
			;;
	esac
}