local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local dpi = require ('beautiful.xresources').apply_dpi
local pi = require ('widget.util.panel_item')

local time = function (s)
  local time_box = awful.popup {
    visible = true,
    screen = s,
    ontop = true,
    x = dpi(3),
    y = dpi(-1),
    splash = true,
    shape = gears.shape.rounded_bar,
    widget = pi { 
      widget = wibox.widget.textclock(),
      shape = gears.shape.rounded_bar,
      margins = dpi(3),
    }
  }
  return time_box
end

return time
