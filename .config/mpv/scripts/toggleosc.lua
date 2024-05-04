--
-- A lua script to toggle the mouse's OSC in mpv
--

-- Settings and Config --
-- default key: o
-- default OSC state: auto
local settings = {
  key_toggle = "o",
  is_auto = true
}

-- Function to toggle the OSC.
function toggle_osc()
  -- Set the is_auto variable to false for initial check.
  settings.is_auto = not settings.is_auto

  -- MPV command to run.
  mp.commandv('script-message', 'osc-visibility', settings.is_auto and 'auto' or 'always')

  -- A command I found online that doesn't seem to work.
  -- url: https://github.com/mpv-player/mpv/issues/9951
  --mp.commandv('script-message', 'osc-visibility', osc_always_on and 'auto' or 'always')
end

-- Add keybinding to MPV
mp.add_key_binding(settings.key_toggle, "toggle-osc", toggle_osc)
