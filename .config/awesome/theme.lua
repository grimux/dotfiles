--[[

     Dracula Awesome WM theme 2.0
     Jake Meredith

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome"
theme.wallpaper                                 = theme.confdir .. "/wall.png"
theme.font                                      = "Mononoki Nerd Font 9"
theme.menu_bg_normal                            = "#282a36"
theme.menu_bg_focus                             = "#282a36"
theme.bg_normal                                 = "#282a36"
theme.bg_focus                                  = "#282a36"
theme.bg_urgent                                 = "#282a36"
theme.fg_normal                                 = "#f8f8f2"
theme.fg_focus                                  = "#ffb86c"
theme.fg_urgent                                 = "#ff5555"
theme.fg_minimize                               = "#f8f8f2"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#44475a"
theme.border_focus                              = "#bd93f9"
theme.border_marked                             = "#ff5555"
theme.menu_border_width                         = 0
theme.menu_width                                = dpi(130)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#8be9fd"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.widget_temp                               = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                             = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                            = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                 = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                = theme.confdir .. "/icons/mem.png"
theme.widget_note                               = theme.confdir .. "/icons/note.png"
theme.widget_note_on                            = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                            = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                               = theme.confdir .. "/icons/mail.png"
theme.widget_batt                               = theme.confdir .. "/icons/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                = theme.confdir .. "/icons/spkr.png"
theme.widget_sleep                              = theme.confdir .. "/icons/moon.png"
theme.widget_tvmode                             = theme.confdir .. "/icons/television.png"
theme.taglist_squares_sel                       = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                     = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup


-------------------------
-- My Personal Widgets --
-------------------------
--
-- TV mode widget --
-- Old watch method
--local tv_mode_status = awful.widget.watch('tv_mode_status', 5)
--
-- Get the status of TV Mode.
function get_tv_mode_status()
    local file = io.open(os.getenv("HOME") .. "/.cache/tv_mode_on","r")
    if file ~= nil then io.close(file) return true else return false end
end

-- TV Mode widget and icon
local tvmodeicon = wibox.widget({
    widget = wibox.widget.imagebox,
    image = theme.widget_tvmode,
    visible = false
})

local tvmode_widget = wibox.widget ({
    widget = wibox.widget.textbox,
    text = "TV Mode",
    opacity = 0.75,
    visible = false
})

-- Signal to send for TV Mode.
awesome.connect_signal('update_tv_mode_status', function()
    local tv_status = get_tv_mode_status()

    if( tv_status ) then
        tvmodeicon.visible = true
        tvmode_widget.visible = true
    else
        tvmodeicon.visible = false
        tvmode_widget.visible = false
    end
end)


--
-- Brown Noise widget (mpv) --
--
-- Brown noise widget and icon
local brownnoiseicon = wibox.widget({
    widget = wibox.widget.imagebox,
    image = theme.widget_note_on,
    visible = false
})

local brownnoise_widget = wibox.widget({
    widget = wibox.widget.textbox,
    text = "Brown Noise",
    opacity = 0.75,
    font = theme.font,
    visible = false

})

-- Get the status for brown noise.
function get_brown_noise_status()
    -- Check for running mpv process.
    local processName = "Brown_Noise_8%-Hours%.mp3"
    local processList = io.popen("ps -ef"):read("*a")
    if string.match(processList, processName) then
        return true
    else
        return false
    end
end

-- Signal to send for brown noise.
awesome.connect_signal('update_brown_noise_status', function()
    local mpv_status = get_brown_noise_status()

    if( mpv_status ) then
        brownnoiseicon.visible = true
        brownnoise_widget.visible = true
    else
        brownnoiseicon.visible = false
        brownnoise_widget.visible = false
    end
end)


--
-- Monitor Sleep Status --
--
-- Monitor sleep icon imagebox.
local monitorsleepicon = wibox.widget({
    widget = wibox.widget.imagebox,
    image = theme.widget_sleep,
    visible = false
})

-- Monitor Sleep widget and icon
local monitorsleep_widget = wibox.widget({
    widget = wibox.widget.textbox,
    text = "Sleep Off",
    opacity = 0.75,
    font = theme.font,
    visible = false
})

-- Get the status of the monitor.
function get_monitor_sleep_status()
    local sleep_disabled = "DPMS is Enabled"
    local xset_status = io.popen("xset q | grep \"DPMS is Enabled\""):read("*a")
    if string.match(sleep_disabled, xset_status) then
        return true
    else
        return false
    end
end

-- Signal to send for monitor sleep status.
awesome.connect_signal('update_monitor_sleep_status', function()
    local monitor_sleep_status = get_monitor_sleep_status()

    if( monitor_sleep_status ) then
        monitorsleepicon.visible = true
        monitorsleep_widget.visible = true
    else
        monitorsleepicon.visible = false
        monitorsleep_widget.visible = false
    end
end)

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %I:%M %P "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Mononoki 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
-- to be set before use
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    APPID = "3e321f9414eaedbfab34983bda77a66e",
    units = "imperial",
    lat = 38.61670684814453,
    lon = -95.26720428466797,
    notification_preset = { font = "Mononoki 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°F"))
    end
})


-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
    notification_preset = { font = "Mononoki 10", fg = theme.fg_normal },
    settings  = function()
        widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
    end
})

-- Mail IMAP check
--[[ to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    timeout = 2,
    tempfile = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp2_input", -- AMD CPU
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
local volumealsa = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
    end
})

-- PulseAudio volume (based on multicolor theme)
local volumepulse = lain.widget.pulse {
    timeout = 2,
    settings = function()
        vlevel = volume_now.left .. "-" .. volume_now.right .. "% | " .. volume_now.description
        if volume_now.muted == "yes" then
            vlevel = vlevel .. " M"
        end
        widget:set_markup(lain.util.markup("#7493d2", vlevel))
    end
}

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        -- uncomment if using the weather widget
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end
        --

        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
    end
})

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
    notify = "off",
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(theme.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            --mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(theme.font, "#ff5555", artist) .. markup.fontfg(theme.font, "#f8f8f2", title))
    end
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    --[[
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
    --]]

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(19), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
            mpdicon,
            theme.mpd.widget,
        },
        --s.mytasklist, -- Middle widget
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            monitorsleepicon,
            monitorsleep_widget,
            brownnoiseicon,
            brownnoise_widget,
            tvmodeicon,
            tvmode_widget,
            --mailicon,
            --theme.mail.widget,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo.widget,
            volicon,
            --theme.volume.widget
            volumepulse.widget,
            --volumealsa.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            tempicon,
            --cputemp,
            temp.widget,
            fsicon,
            theme.fs.widget,
            weathericon,
            theme.weather.widget,
            --baticon,
            --bat.widget,
            clockicon,
            mytextclock,
            wibox.widget.systray(),
        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
        },
    }
end

return theme
