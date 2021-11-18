local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('util.toggle')
local ib = require ('util.img_button')
-- local textbox = require ('util.select_textbox')
local gen_toggle = require ('widget.settings.content_view.gen_toggle')

local general = wibox.widget {
  gen_toggle {
    text = 'Profile Image',
    cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Choose a new profile picture?'
  },
  gen_toggle {
    text = 'test2',
    cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Send a notification'
  },
  layout = wibox.layout.flex.vertical
}
general.max_widget_size = dpi(50)

return general


