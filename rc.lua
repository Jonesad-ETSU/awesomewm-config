pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- local dpi = beautiful.xresources.apply_dpi
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
--if not beautiful.init(require('themes.mine')) then
if not beautiful.init(require('themes.gtk')) then
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

-- local function set_wallpaper(s)
--   -- Wallpaper
--   if beautiful.wallpaper then
--     local wallpaper = beautiful.wallpaper
--     -- If wallpaper is a function, call it with the screen
--     if type(wallpaper) == "function" then
--       wallpaper = wallpaper(s)
--     end
--     gears.wallpaper.maximized(wallpaper, s, true)
--   end
-- end

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
require ('config.titlebar')
require ('config.focus')
require ('config.notifications')

