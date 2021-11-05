local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

return wibox.widget {
  require('widget.button.airplane'),
  -- require('widget.button.gamer'),
  require('widget.button.night'),
  require('widget.button.disturb'),
  spacing = dpi(6),
  layout = wibox.layout.flex.vertical
}
