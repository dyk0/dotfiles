-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()
-- Widgets
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local cw = calendar_widget({
    placement = 'top_right'
})
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")
local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      RC.launcher,
      s.mytaglist,
      s.mypromptbox,
      wibox.widget.systray({
        visible = false
      }),
    },
      s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      todo_widget(),
      cpu_widget(),
      ram_widget(),
      spotify_widget({
        font = 'Hack 7',
        play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
        pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
        dim_when_paused = true,
        dim_opacity = 0.5,
        max_length = -1,
        show_tooltip = false,
      }),
      volumearc_widget({
        main_color = '#13aff7',
        mute_color = '#ff0000',
        thickness = 5,
        height = 25,
--        button_press = function(_, _, _, button)   -- Overwrites the button press behaviour to open pavucontrol when clicked
--          if (button == 1) then awful.spawn('pavucontrol --tab=3', false)
--          end
--        end
      }),
      mytextclock,
      s.mylayoutbox,
    },
  }
end)
-- }}}
