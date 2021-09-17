local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local gfs = require ('gears.filesystem')
local wibox = require ('wibox')
local gears = require ('gears')
local beautiful = require ('beautiful')

local power_btn = ib {
  -- image = gfs.get_configuration_dir() .. '/widget/button/power/power.svg',
  widget = wibox.widget {
    markup = "<b>Power</b>",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
  },
  show_widget = "widget.power_popup",
  tooltip	= "Open Shutdown Prompt",
}

return pi {
  widget = power_btn,
  shape = gears.shape.rectangle,
  margins = 0
}
