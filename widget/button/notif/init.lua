local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
local gears  = require ('gears')
local wibox = require ('wibox')
local gfs = gears.filesystem
-- local gfs = require ('gears.filesystem')
-- local color = require ('gears.color')
-- local dpi = require ('beautiful.xresources').apply_dpi

local notif_btn = ib {
  image = gfs.get_configuration_dir() .. 'icons/notifications.svg',
  recolor = true,
  -- widget = wibox.widget {
  --   markup = "Notify",
  --   align = 'center',
  --   font = beautiful.font,
  --   widget = wibox.widget.textbox
  -- },
  hide_tooltip = true,
  cmd = "discord",
}

return pi {
  widget = notif_btn,
  shape = gears.shape.rounded_rect,
  margins = dpi(4),
  bg = beautiful.panel_item.button_bg
  -- name = "Notif",
  -- margins = dpi(12),
  -- ratio = {
  --   target 	= 2,
  --   before 	= 0.8,
  --   at 	        = 0.2,
  --   after 	= 0
  -- }
}
