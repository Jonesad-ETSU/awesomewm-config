local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gfs = require ('gears.filesystem')
local wibox = require ('wibox')
local gears = require ('gears')
local beautiful = require ('beautiful')

local power_btn = ib {
  image = gfs.get_configuration_dir() .. '/icons/switch.svg',
  recolor = true,
  -- widget = wibox.widget {
  --   -- {
  --     markup = "Power",
  --     font = beautiful.font,
  --     align = 'center',
  --     widget = wibox.widget.textbox
  --   -- },
  --   -- fg = beautiful.bg_urgent,
  --   -- widget = wibox.container.background
  -- },
  show_widget = "widget.power_popup",
  tooltip	= "Open Shutdown Prompt",
}

return pi {
  widget = power_btn,
  shape = gears.shape.rounded_rect,
  bg = beautiful.panel_item.button_bg,
  margins = 3
}
