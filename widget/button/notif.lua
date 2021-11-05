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
  image = 'notifications.svg',
  recolor = true,
  hide_tooltip = true,
  show_widget = 'layout.notifications',
  -- cmd = "discord",
}

return pi {
  widget = notif_btn,
  shape = beautiful.rounded_rect_shape,
  margins = dpi(6),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg,
}
