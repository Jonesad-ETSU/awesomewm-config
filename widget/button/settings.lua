local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local wibox = require ('wibox')

local gfs = gears.filesystem
local dpi = beautiful.xresources.apply_dpi

local settings_btn = ib {
  image = 'settings.svg',
  recolor = true,
  show_widget = "layout.settings",
  tooltip = 'Show Settings window',
}

return pi {
  widget = settings_btn,
  shape = beautiful.rounded_rect_shape,
  margins = dpi(6),
  bg = beautiful.panel_item.bg
}
