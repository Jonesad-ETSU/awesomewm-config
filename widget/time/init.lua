local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local pi  = require ('widget.util.panel_item')
--local ib  = require ('widget.util.img_button')

local time = wibox.widget {
  {
    format = "<span font='"..beautiful.font.." 12'>%a, %b %d %I:%M %p</span>",
    widget = wibox.widget.textclock
  },
  widget = wibox.container.place
}

return pi {
  widget = time,
  margins = dpi(2)
}
