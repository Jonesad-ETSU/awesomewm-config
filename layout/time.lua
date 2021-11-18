local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local darker = require ('util.color').darker
local pi = require ('util.panel_item')
local dpi = beautiful.xresources.apply_dpi

local time = function (s,side)
  local time_box = wibox {
      visible = true,
      screen = s,
      type = 'dock',
      ontop = true,
      width = dpi(60),
      height = dpi(15),
      border_width = beautiful.panel.border_width,
      border_color = beautiful.panel.border_color,
      splash = true,
      shape = beautiful.rounded_rect_shape,
      widget = {}
  }
  time_box : setup {
    pi {
      widget = wibox.widget {
        {
          format = "%I:%M %p",
          font = beautiful.small_font,
          widget = wibox.widget.textclock
        },
        widget = wibox.container.place
      },
      shape = beautiful.rounded_rect_shape,
      margins = dpi(3),
      -- margins = 0,
    },
    layout = wibox.layout.flex.horizontal
  }

  if side == 'top' then 
    awful.placement.top_right(time_box)
  else 
    awful.placement.bottom_right(time_box)
  end

  return time_box
end

return time
