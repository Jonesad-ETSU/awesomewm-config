local toggle = require ('widget.util.toggle')
local pi = require ('widget.util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
-- local gears  = require ('gears')
local wibox = require ('wibox')
-- local gfs = gears.filesystem
-- local gfs = require ('gears.filesystem')
-- local color = require ('gears.color')
-- local dpi = require ('beautiful.xresources').apply_dpi

local disturb = toggle {
  img = 'bell.svg',
  -- on_cmd = [[ awesome-client 'require("naughty").emit_signal("request::do_not_disturb")' && notify-send 'Do Not Disturb' 'On' ]],
  on_cmd = [[ awesome-client 'local n = require("naughty") local g = require ("gears") n.notification { title = "Do Not Disturb", message = "Turning On...", icon=g.filesystem.get_configuration_dir().."/icons/bell.svg"} g.timer.start_new(3, function() n.suspended = true n.destroy_all_notifications() return false end)' ]],
  -- on_cmd = [[ awesome-client 'require("naughty").notify { text = "testing"}' && notify-send 'Do Not Disturb' 'On' ]],
  off_cmd = [[ awesome-client 'require("naughty").suspended = false' && notify-send 'Do Not Disturb' 'Off' ]],
  -- off_cmd = [[ awesome-client 'require("naughty").emit_signal("request::do_not_disturb")' && notify-send 'Do Not Disturb' 'Off' ]],
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
