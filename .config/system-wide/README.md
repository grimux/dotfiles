System Configuration Files
==========================

<<!--
TODO
----
- Add descriptions.
- Check for other system-wide config files and move them to new location.
-->>

These are system wide configuration files (in the form of `systemd` drop-in files mostly).  They are saved here and can be applied using a as of now (Sunday, February 11, 2024) not written yet.  Though I might change my mind.

Configuration Files
-------------------

### X11
#### `00-keyboard.conf`
A custom keyboard profile.  It allows "zapping" `X11` (killing `X11` with a keystroke, in this case `ctrl+alt+backspace`) and setting `ESC` to `CAP LOCK`.  This system-wide configuration is preferred over setting `setxkbmap -option caps:escape` in `.xinitrc` because applications such as `wine`, `proton`, and other games like to restore `CAPS` to its normal state.  Setting at the system level seems to prevent this.

This file needs to be placed in the following location:

`/etc/X11/xorg.conf.d/`

It will then be loaded automatically when using `X11`.


### Auto-login
#### `autologin.conf`


### Drive Mounting
#### `fstab`


### Autostart Desktop Files
#### `pasystray`
