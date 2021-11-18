local toggle = require ('util.toggle')
local pi = require ('util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
local wibox = require ('wibox')

local night = toggle {
  img = 'moon.svg',
  on_cmd = [[awesome-client 'local g=require("gears") require("naughty").notification { title = "Blue Light Filter", message = "On (2500k)",icon=g.color.recolor_image(g.filesystem.get_configuration_dir().."/icons/moon.svg",require("beautiful").wibar_fg)}' && redshift -PO 2500k]],
  off_cmd = [[awesome-client 'local g=require("gears") require("naughty").notification { title = "Blue Light Filter", message = "Off (6500k)",icon=g.color.recolor_image(g.filesystem.get_configuration_dir().."/icons/moon.svg",require("beautiful").wibar_fg)}' && redshift -PO 6500k]],
  active_bg = beautiful.transparent,
  inactive_bg = beautiful.transparent,
  active_fg = beautiful.bg_select,
  inactive_fg = beautiful.wibar_fg, 
  tooltip = 'Toggles Blue Light Filter.',
  margins = dpi(10)
}

return pi {
  widget = wibox.widget { 
    night,
    widget = wibox.container.place
  },
  shape = beautiful.rounded_rect_shape,
  margins = 0,
  -- margins = dpi(12),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg,
}
