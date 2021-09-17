local awful = require ('awful')
local wibox = require ('wibox')
local beautiful = require ('beautiful')
local pi    = require ('widget.util.panel_item')

local txt = wibox.widget {
  font   = beautiful.font,
  valign = 'center',
  align  = 'center',
  widget = wibox.widget.textbox
}

awful.spawn.easy_async_with_shell (
  "cat /etc/motd",
   function(stdout)
    txt.markup = "<b>"..stdout.."</b>"
   end
)

return pi {
  widget = wibox.widget {
    txt,
    widget = wibox.container.place
  }
}
