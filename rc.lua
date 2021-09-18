pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
   title = "Oops, there were errors during startup!",
   text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end
-- }}}
-- Initialize theme
--if not beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/gtk/theme.lua") then
--if not beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/zenburn/theme.lua") then
if not beautiful.init(require('themes.mine')) then
--if not beautiful.init(require('themes.mine')) then
  naughty.notify { text = "Failed to load theme."}
end
-- beautiful.font = "Roboto 8"
-- if not beautiful.wibar_bg then
--   naughty.notify { text = "RIP 2"}
-- end

-- Bling relies on beautiful's properties, thus must be set after.
local bling = require ('bling')
-- Panel relies on layout
local panel = require ('layout')

-- Set taskbar  icon size
awesome.set_preferred_icon_size(32)

-- Run autostart shell script
awful.spawn.easy_async_with_shell(gears.filesystem.get_configuration_dir() .. "autostart" )

naughty.notify({
  title = "Loaded",
  text = "Running jonesad's configuration files",
  timeout = 3,
  position = 'bottom_middle',
})


terminal = os.getenv("TERMINAL") or "alacritty"
editor = os.getenv("EDITOR") or "vim"
sysmonitor = os.getenv("SYSMONITOR") or "gotop"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

require ('config.layouts')
require ('config.menu')

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

bat_widget = wibox.widget {
    widget = awful.widget.watch("bash -c \"upower -i $(upower -e | grep BAT) | awk '/percentage/ {print $2}'\"", 60),
    layout = wibox.layout.fixed.horizontal
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
   if c == client.focus then
     c.minimized = true
   else
     c:emit_signal(
       "request::activate",
       "tasklist",
       {raise = true}
     )
   end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
   end),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
   end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
   end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal(
  "property::geometry",
  function()
    awful.spawn([[nitrogen --restore]])
  end
)

awful.screen.connect_for_each_screen(function(s)

  s.padding = {
    left=5,
    right=5,
    top=20,
    bottom=5
  }

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])
end)
--[[
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous = true,
        expand = true,
        layout = {
            {
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            widget = wibox.layout.fixed.vertical
        },
        buttons = taglist_buttons
    }


    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
	layout = {
		spacing_widget = {
			{
				forced_width = 64,
				forced_height = 64,
				thickness = 0,
				color = '#777777',
				widget = wibox.widget.separator
			},
			valign = 'center',
			halign = 'center',
			widget = wibox.container.place,
		},
		spacing = 1,
		layout = wibox.layout.fixed.vertical
	},
	widget_template = {
		{
			wibox.widget.base.make_widget(),
			forced_height = 5,
			id = 'background_role',
			widget = wibox.container.background,
		},
		{
			{
				id = 'clienticon',
				widget = awful.widget.clienticon,
			},
			bottom = 3,
			left = 3,
			right = 3,
			top = 3,
			widget = wibox.container.margin,
		},
        nil,
		create_callback = function (self, c, index, objects) 
			self:get_children_by_id('clienticon')[1].client = c
		end,
		layout = wibox.layout.align.horizontal,
	}
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "left", 
    	screen = s,
	--height = 40,
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.vertical,
        { -- Left widgets
            layout = wibox.layout.fixed.vertical,
            mylauncher,
            s.mypromptbox,
        },
	-- Middle widgets
	{
        layout = wibox.layout.align.vertical,
        nil,
        s.mytasklist, 
        nil
	},
	{ -- Right widgets
            layout = wibox.layout.fixed.vertical,
            --mykeyboardlayout,
            s.mytaglist,
            s.mylayoutbox,
            wibox.widget.systray(),
            mytextclock,
            bat_widget,
            power_widget,
        },
    }
end)
--]]
-- }}}
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

require ('config.binds.global')
require ('config.binds.client')
require ('config.rules')

-- Add a titlebar if titlebars_enabled is set to true in the rules.
--

local double_click_event_handler = function(event)

	if time_handler then
		--time_handler:stop()
		time_handler = nil
		event()
		return
	end

	time_handler = gears.timer.start_new( .250,
		function()
			time_handler = nil
			return false
		end
	)
end

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
	    double_click_event_handler(function()
		if c.floating then
			c.floating = false
			return
		end
		c.maximized = not c.maximized
		c:raise()
		return
	    end)
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {position = 'top', bg = beautiful.wibar_bg, size = 40}) : setup {
        nil,
	-- { -- Left
	--           {
	--             {
	--               {
	--                 awful.titlebar.widget.iconwidget(c),
	--                 awful.titlebar.widget.stickybutton   (c),
	--                 buttons = buttons,
	--                 layout  = wibox.layout.fixed.horizontal
	--               },
	--               margins = 5,
	--               widget = wibox.container.margin
	--             },
	--             shape = gears.shape.rounded_rect,
	--             bg = "#bb00bb",
	--             widget = wibox.container.background
	--           },
	--           left = 0,
	--           widget = wibox.container.margin
	-- },
	{ -- Middle
	    { -- Title
		align  = "center",
		widget = awful.titlebar.widget.titlewidget(c)
	    },
	    buttons = buttons,
	    layout  = wibox.layout.flex.horizontal
	},
	{ -- Right
          -- {
            -- {
              -- awful.titlebar.widget.minimizebutton (c),
              awful.titlebar.widget.stickybutton   (c),
              awful.titlebar.widget.closebutton    (c),
              layout = wibox.layout.fixed.horizontal()
            -- },
            -- margins = 10,
            -- widget = wibox.container.margin
          },
	--           bg = "#ffffff",
	--           shape = gears.shape.rounded_rect,
	--           widget = wibox.container.background
	-- },
	layout = wibox.layout.align.horizontal
      }
end)

-- enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- ]]
