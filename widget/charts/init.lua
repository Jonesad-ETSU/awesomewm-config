local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local wibox = require ('wibox')
local pi = require ('widget.util.panel_item')
local cpu = require ('widget.arccharts.cpu')
local ram = require ('widget.arccharts.ram')

return pi {
  widget = wibox.widget {
    layout = wibox.layout.flex.horizontal,
    spacing = 0,
    cpu,
    ram,
  },
  left = dpi(30),
  right = dpi(30),
  margins = dpi(15),
  outer = true,
}
