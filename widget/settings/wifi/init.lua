local wibox = require ('wibox')
local beautiful = require ('beautiful')

local wifi = wibox.widget {
  {
    markup = "WiFi",
    align = 'center',
    font = beautiful.font,
    widget = wibox.widget.textbox
  },
  widget = wibox.container.place
}

return wifi
