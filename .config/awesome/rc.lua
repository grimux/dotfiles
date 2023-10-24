--[[

     Awesome WM configuration template
     To be used with the themes from copycat
     Jake Meredith

--]]

-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100
local lain          = require("lain")
--local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
                      --require("awful.hotkeys_popup.keys")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
local quake = lain.util.quake()

-- }}}

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        }

        in_error = false
    end)
end

-- Toggle showing the desktop
local show_desktop = false
function show_my_desktop()
  if show_desktop then
    for _, c in ipairs(client.get()) do
      c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
      )
    end
    show_desktop = false
  else
    for _, c in ipairs(client.get()) do
      c.minimized = true
    end
    show_desktop = true
  end
end

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

--run_once({ "urxvtd", "unclutter -root" }) -- comma-separated entries

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "alacritty"
local vi_focus     = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274

-- Default programs
local editor       = os.getenv("EDITOR") or "nvim"
local browser      = "firefox"
local htmlwiki     = " ~/vimwiki/_site/index.html"
--local music        = terminal .. " --class ncmpcpp -e ncmpcpp"
local music        = "cantata"
local termfile     = terminal .. " --class ranger -e ranger"
local filemanager  = "pcmanfm-qt"

awful.util.terminal = terminal
awful.util.tagnames = { "term", "www", "file", "email", "torr", "chat", "mus", "vid", "gfx" }
awful.layout.layouts = {
  awful.layout.suit.tile,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

awful.util.taglist_buttons = mytable.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = mytable.join(
     awful.button({ }, 1, function(c)
         if c == client.focus then
             c.minimized = true
         else
             c:emit_signal("request::activate", "tasklist", { raise = true })
         end
     end),
     awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
     end),
     awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

--beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- }}}

-- {{{ Menu

-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", string.format("%s -e man awesome", terminal) },
   { "Edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

local mysysmenu = {
  { "quit", function() awesome.quit() end },
  { "reboot", "systemctl reboot" },
  { "shutdown", "shutdown now" },

}

awful.util.mymainmenu = freedesktop.menu.build {
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
    { "Power", mysysmenu },
        { "Open terminal", terminal },
        -- other triads can be put here
    }
}

-- Hide the menu when the mouse leaves it
--[[
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
    if not awful.util.mymainmenu.active_child or
       (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
       awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
        function()
            if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                awful.util.mymainmenu:hide()
            end
        end)
    end
end)
--]]

-- Set the Menubar terminal for applications that require it
--menubar.utils.terminal = terminal

-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized or c.fullscreen then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}

-- {{{ Mouse bindings

root.buttons(mytable.join(
    --awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
    --awful.button({ }, 5, awful.tag.viewprev)


))


--[[
clientbuttons = mytable.join(
    awful.button({ }, 6, function() awful.spawn("/dev/null") end), -- Scroll wheel left
    awful.button({ }, 7, function() awful.spawn("/dev/null") end), -- Scroll wheel right
    awful.button({ }, 8, function() awful.spawn("screenshooter") end), -- Thumb button back
    awful.button({ }, 9, function() awful.spawn("/dev/null") end) -- Thumb button forward
)
--]]

-- }}}

-- {{{ Key bindings

globalkeys = mytable.join(
    -- Show help
    awful.key({ modkey, "Shift"   }, "/",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

   -- Cycle through windows
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- all minimized clients are restored
        awful.key({ modkey, "Shift"   }, "n",
            function()
                local tag = awful.tag.selected()
                    for i=1, #tag:clients() do
                        tag:clients()[i].minimized=false
                        --tag:clients()[i]:redraw()
                end
            end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

  -- Layout Sizing
  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

  -- Layout cycling
  awful.key({ modkey,           }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Show/hide wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On-the-fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "programs"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
    --          {description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --          {description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    --          {description = "show weather", group = "widgets"}),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            os.execute("mpc toggle")
            beautiful.mpd.update()
        end,
        {description = "mpc toggle", group = "mpd"}),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            os.execute("mpc stop")
            beautiful.mpd.update()
        end,
        {description = "mpc stop", group = "mpd"}),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            os.execute("mpc prev")
            beautiful.mpd.update()
        end,
        {description = "mpc prev", group = "mpd"}),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            os.execute("mpc next")
            beautiful.mpd.update()
        end,
        {description = "mpc next", group = "mpd"}),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        {description = "mpd on/off", group = "widgets"}),
    awful.key({ "Control" }, "m",
        function ()
    awful.spawn("mpd-status")
  end,
  {description = "mpd status", group = "mpd"}),

    -- User programs
    awful.key({ modkey,           }, "w",     function () awful.spawn(browser) end,
              { description = "browser", group = "programs"}),
    awful.key({ modkey, "Shift"   }, "w",     function () awful.spawn(browser .. htmlwiki) end,
              { description = "vimwiki", group = "programs"}),
    awful.key({ modkey,           }, "e",     function () awful.spawn(filemanager) end,
              { description = "file manager", group = "programs"}),
    awful.key({ modkey,           }, "m",     function () awful.spawn(music) end,
              { description = "music", group = "programs"}),
    awful.key({ modkey,           }, "r",     function () awful.spawn(termfile) end,
              { description = "ranger", group = "programs"}),
    awful.key({ modkey,           }, "p",     function () awful.spawn("passmenu -p pass:") end,
              { description = "passmenu", group = "programs"}),
    awful.key({ modkey, "Shift"   }, "p",     function () awful.spawn("qtpass") end,
              { description = "qtpass", group = "programs"}),
    awful.key({ modkey,           }, "`",     function () awful.spawn("dm-emoji") end,
              { description = "emoji menu", group = "programs"}),
    awful.key({ "Control",        }, "`",     function () awful.spawn("clipmenu -p clips:") end,
              { description = "qtpass", group = "programs"}),
    awful.key({ modkey,           }, "c",     function () awful.spawn("qalculate-gtk") end,
              { description = "qalculate-gtk", group = "programs"}),
    awful.key({ modkey,           }, "t",     function () awful.spawn("transmission-remote-gtk") end,
              { description = "transmission remote gtk", group = "programs"}),
    awful.key({ modkey, "Shift"   }, "d",     function () awful.spawn("jdownloader") end,
              { description = "jDownloader2", group = "programs"}),
    awful.key({ modkey            }, "v",     function () awful.spawn("pavucontrol --tab=1") end,
              { description = "pavucontrol", group = "programs"}),
    awful.key({ modkey, "Shift"   }, "z",     function () awful.spawn("filezilla") end,
              { description = "pavucontrol", group = "programs"}),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.spawn("openrgb") end,
              { description = "openrgb", group = "programs"}),


    -- Script Launching
    awful.key({ modkey,           }, "F1",     function () awful.spawn("gametime") end,
              { description = "gametime", group = "scripts"}),
    awful.key({ modkey, "Shift"   }, "F1",     function () awful.spawn("play -d") end,
              { description = "gametime", group = "scripts"}),

    awful.key({ modkey,        }, "F5",     function ()
          awful.spawn.with_line_callback("tv_mode", {
              exit = function()
                  awesome.emit_signal('update_tv_mode_status')
              end})
    end,
              { description = "TV mode toggle", group = "scripts"}),

    awful.key({ modkey,        }, "F6",     function () awful.spawn("toggle-conky") end,
              { description = "toggle conky", group = "scripts"}),
    awful.key({ modkey,        }, "F7",     function () awful.spawn("toggle-alpha") end,
              { description = "toggle compositor", group = "scripts"}),
    awful.key({ modkey,        }, "F8",     function () awful.spawn("audio-device-switch") end,
              { description = "change audio output", group = "scripts"}),
    awful.key({ modkey,        }, "F9",     function () awful.spawn("toggle-transmission") end,
              { description = "toggle transmission", group = "scripts"}),
    awful.key({ modkey,        }, "F10",     function () awful.spawn("toggle-tor") end,
              { description = "toggle Tor Network", group = "scripts"}),

    awful.key({ modkey, }, "z", function () quake:toggle() end),

   -- dmenu scripts
    awful.key({ modkey, "Shift" }, "e",     function () awful.spawn("dm-confedit") end,
              { description = "edit configs", group = "dmenu"}),
    awful.key({ modkey, "Shift" }, "s",     function () awful.spawn("dm-sounds") end,
              { description = "soundscapes", group = "dmenu"}),
    awful.key({ modkey }, "s",     function () awful.spawn("dm-websearch") end,
              { description = "web search", group = "dmenu"}),
    awful.key({ modkey, "Shift"   }, "m",     function () awful.spawn("dm-playlists-music") end,
              { description = "music playlists", group = "dmenu"}),
    awful.key({ modkey, "Shift"   }, "v",     function () awful.spawn("dm-playlists-videos") end,
              { description = "video playlists", group = "dmenu"}),
    awful.key({ modkey, "Shift"   }, "x",     function () awful.spawn("dm-g910") end,
              { description = "keyboard profile", group = "dmenu"}),


   -- Functions
   -- Show desktop. My function for this is above.
  awful.key({ altkey, "Control" }, "d", function(c) show_my_desktop() end,
    {description = "toggle showing the desktop", group = "client"}),

   -- Media Keys
   awful.key({}, "XF86AudioPlay", function()
     awful.util.spawn("playerctl play-pause", false) end),
   awful.key({}, "XF86AudioStop", function()
     awful.util.spawn("playerctl stop", false) end),
   awful.key({}, "XF86AudioNext", function()
     awful.util.spawn("playerctl next", false) end),
   awful.key({}, "XF86AudioPrev", function()
     awful.util.spawn("playerctl previous", false) end),

   -- Volume Keys
   awful.key({}, "XF86AudioMute", function()
     awful.util.spawn("volume_adjust mute", false) end),
   awful.key({}, "XF86AudioLowerVolume", function()
     awful.util.spawn("volume_adjust down", false) end),
   awful.key({}, "XF86AudioRaiseVolume", function()
     awful.util.spawn("volume_adjust up", false) end),

   -- Screenshot
   awful.key({}, "Print", function () awful.spawn("screenshooter") end),

   -- Set Caps to escape
   awful.key({ modkey, "Control" }, "k", function() awful.spawn("set_caps_to_esc") end,
    { description = "Set Caps to ESC", group = "misc"}),

  -- Dmenu
  awful.key({ modkey,         }, "space", function () awful.spawn("dmenu_run -i -p run:") end,
    { description = "dmenu", group = "programs"}),
  awful.key({ modkey, "Shift" }, "space", function () awful.spawn("sudo dmenu_run -i -p sudo:") end,
    { description = "sudo dmenu", group = "programs"}),



    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = mytable.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ altkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ altkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ altkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = mytable.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

--[[
-- Show titlesbars for floating windows only
client.connect_signal("property::floating", function(c)
    if c.floating and not c.maximized or c.fullscreen then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)
--]]

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     callback = awful.client.setslave,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered+awful.placement.no_offscreen,
                     --placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
	  "Godot_Engine",
          "pinentry",
          "qalculate-gtk",
          "virt-manager",
        },
        class = {
          "Arandr",
          "Blueman-manager",
	  "fury.bin",
          "Gpick",
          "Gzdoom",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Nm-connection-editor", -- network-manager-applet
	  "org-gdstash-ui-GDStashFrame", -- GDStash for Grim Dawn
          "PolyMC", --
          "Pavucontrol",
          ".*exe",  -- Automatically float any window that containes "exe".  This works for most games or applications run through wine.
	  "Raze",
          "SGDBoop",
          "smapi",  --  Stardew Valley modding framework.  Runs in alacritty window with class name "smapi".
          "steam_app_%d", -- Let steam games default to floating.  %d is a wildcard for integers.
          "Sxiv",
          "feh",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Yad",
          "Zathura",  -- PDF viewer
         },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    --
    -- Tag Rules
    --
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
    --
    -- www
    { rule = { class = "firefox" },        properties = { screen = 1, tag = awful.util.tagnames[2] } },
    -- file
    -- email
    { rule = { class = "thunderbird" },    properties = { screen = 1, tag = awful.util.tagnames[4] } },
    -- torr
    { rule = { class = "qBittorrent" },    properties = { screen = 1, tag = awful.util.tagnames[5] } },
    { rule = { class = "Transmission-remote-gtk" },    properties = { screen = 1, tag = awful.util.tagnames[5] } },
    -- chat
    { rule = { class = "discord" },        properties = { screen = 1, tag = awful.util.tagnames[6] } },
    { rule = { class = "Signal" },         properties = { screen = 1, tag = awful.util.tagnames[6] } },
    -- mus
    { rule = { class = "cantata" },        properties = { screen = 1, tag = awful.util.tagnames[7] } },
    { rule = { class = "ncmpcpp" },        properties = { screen = 1, tag = awful.util.tagnames[7] } },  -- The class "ncmpcpp" is defined above by the "music" variable.  Class is set by calling the terminal.
    -- vid
    --{ rule = { class = "mpv" },            properties = { screen = 1, tag = awful.util.tagnames[8] } },
    { rule = { class = "vlc" },            properties = { screen = 1, tag = awful.util.tagnames[8] } },
    -- gfx
    { rule = { class = "PolyMC" },         properties = { screen = 1, tag = awful.util.tagnames[9] } },
    { rule = { class = "Lutris" },         properties = { screen = 1, tag = awful.util.tagnames[9] } },
    { rule = { class = "steam" },          properties = { screen = 1, tag = awful.util.tagnames[9] } },
    { rule = { class = "steam_app_%d" },   properties = { screen = 1, tag = awful.util.tagnames[9] } },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = mytable.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 16 }) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

-- Gaps
beautiful.useless_gap = 10
beautiful.gap_single_client = true

-- Disable window snapping
awful.mouse.snap.edge_enabled = false

-- Startup
-- Restart picom to avoid visual bugs
--awful.spawn.with_shell("picom")
-- Restore nitrogen
--awful.spawn.with_shell("nitrogen --restore")
-- Restore feh
awful.spawn.with_shell("~/.fehbg")
