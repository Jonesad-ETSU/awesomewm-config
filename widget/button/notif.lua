local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
local gears  = require ('gears')
local wibox = require ('wibox')
local gfs = gears.filesystem

local notif_btn = ib {
  image = 'notifications.svg',
  recolor = true,
  hide_tooltip = true,
  show_widget = 'layout.notifications',
}

return pi {
  widget = notif_btn,
  shape = beautiful.rounded_rect_shape,
  margins = dpi(6),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg,
}
