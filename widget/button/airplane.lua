local toggle = require ('util.toggle')
local pi = require ('util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
-- local gears  = require ('gears')
local wibox = require ('wibox')
-- local gfs = gears.filesystem
local gfs = require ('gears.filesystem')
-- local color = require ('gears.color')
-- local dpi = require ('beautiful.xresources').apply_dpi

local airplane = toggle {
  img = 'airplane.svg',
  -- img = 'settings.svg',
  on_cmd = gfs.get_configuration_dir()..'/scripts/airplane-mode.sh on',
  off_cmd = gfs.get_configuration_dir()..'/scripts/airplane-mode.sh off',
  -- active_bg = beautiful.wibar_fg,
  active_bg = beautiful.transparent,
  inactive_bg = beautiful.transparent,
  -- active_fg = beautiful.panel_item.bg,
  active_fg = beautiful.bg_select,
  inactive_fg = beautiful.wibar_fg, 
  tooltip = 'Toggles Airplane Mode.\nToggles bluetooth and wifi radio recievers.',
  margins = dpi(10)
}

return pi {
  widget = wibox.widget { 
    airplane,
    widget = wibox.container.place
  },
  shape = beautiful.rounded_rect_shape,
  margins = 0,
  -- margins = dpi(12),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg,
}
