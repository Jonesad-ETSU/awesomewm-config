local wibox = require ('wibox')
local beautiful = require ('beautiful')
local pi  = require ('widget.util.panel_item')
--local ib  = require ('widget.util.img_button')

local time = wibox.widget {
  {
    format = "<span font='"..beautiful.font.." 12'>%a, %b %d %n %I:%M %p</span>",
    widget = wibox.widget.textclock
  },
  widget = wibox.container.place
}

return pi {
  widget = time
}
