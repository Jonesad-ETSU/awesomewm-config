local wibox = require ('wibox')
local pi = require ('widget.util.panel_item')
local cpu = require ('widget.arccharts.cpu')
local ram = require ('widget.arccharts.ram')

return pi {
  widget = wibox.widget {
    layout = wibox.layout.flex.horizontal,
    spacing = 20,
    cpu,
    ram,
  },
  margins = 15,
  outer = true,
}
