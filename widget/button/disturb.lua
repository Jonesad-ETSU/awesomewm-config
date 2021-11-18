local toggle = require ('widget.util.toggle')
local pi = require ('widget.util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
-- local gears  = require ('gears')
local wibox = require ('wibox')
local gfs = require('gears').filesystem
-- local gfs = require ('gears.filesystem')
-- local color = require ('gears.color')
-- local dpi = require ('beautiful.xresources').apply_dpi

local disturb = toggle {
  img = 'bell.svg',
  -- on_cmd = [[ awesome-client 'require("naughty").emit_signal("request::do_not_disturb")' && notify-send 'Do Not Disturb' 'On' ]],
  on_cmd = gfs.get_configuration_dir() .. '/scripts/do-not-disturb.sh on',
  off_cmd = gfs.get_configuration_dir() .. '/scripts/do-not-disturb.sh off',
  active_bg = beautiful.transparent,
  inactive_bg = beautiful.transparent,
  active_fg = beautiful.bg_select,
  inactive_fg = beautiful.wibar_fg, 
  tooltip = "Toggle Do Not Disturb.\nPrevents Notifications.",
  margins = dpi(10)
}

return pi {
  widget = wibox.widget {
    disturb,
    widget = wibox.container.place
  },
  shape = beautiful.rounded_rect_shape,
  margins = 0,
  bg = beautiful.panel_item.bg,
}
