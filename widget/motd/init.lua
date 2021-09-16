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

awful.spawn.with_line_callback (
  "tail -f /etc/motd",
  {
    stdout = function(stdout)
      txt.markup = "<b>"..stdout.."</b>"
    end
  }
)

return pi {
  widget = wibox.widget {
    txt,
    widget = wibox.container.place
  }
}
