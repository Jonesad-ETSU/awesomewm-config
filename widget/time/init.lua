local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local pi  = require ('widget.util.panel_item')

-- require('naughty').notify {text = beautiful.font }
local time = wibox.widget {
  {
    --format = "<span font='"..beautiful.font.." 12'>%a, %b %d %I:%M %p</span>",
    format = "%a, %b %d %I:%M %p",
    font = beautiful.large_font,
    widget = wibox.widget.textclock
  },
  widget = wibox.container.place
}

return pi {
  widget = time,
  margins = dpi(2)
}
