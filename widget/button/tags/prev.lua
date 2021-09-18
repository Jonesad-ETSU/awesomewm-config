local ib = require ('widget.util.img_button')
local beautiful = require ('beautiful')
local awful = require ('awful')
local wibox = require ('wibox')

local prev_tag = ib {
  widget = wibox.widget {
    text = "<-",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
  },
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewprev()
  end)
}

return prev_tag
