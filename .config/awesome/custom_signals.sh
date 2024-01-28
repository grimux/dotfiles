#!/usr/bin/env bash
#
# A list of custom signals I have written for awesome/lain.
# This is my hack for now until I can emplement this into awesome/lain itself,
# i.e. loading my custom status bar modules.
#
# These signals are defined in `theme.lua`, so they can be modifed there.
#
# This file is loaded by the "Startup" section of `rc.lua`.
#

awesome-client '
awesome.emit_signal("update_tv_mode_status")
awesome.emit_signal("update_brown_noise_status")
'

