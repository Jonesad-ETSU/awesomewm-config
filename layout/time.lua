local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local dpi = require ('beautiful.xresources').apply_dpi
local pi = require ('widget.util.panel_item')

local time = function (s)
  local time_box = wibox {
    visible = true,
    screen = s,
    ontop = true,
    width = dpi(60),
    height = dpi(20),
    splash = true,
    shape = gears.shape.rounded_bar,
    widget = pi {
      widget = wibox.widget {
        {
          format = "%I:%M %p",
          widget = wibox.widget.textclock
        },
        widget = wibox.container.place
      },
      shape = gears.shape.rounded_bar,
      margins = dpi(3),
    }
  }

  awful.placement.top_right(time_box)

  return time_box
end

return time
