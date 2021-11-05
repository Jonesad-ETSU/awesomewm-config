local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem

local rofi_btn = ib {
  image = 'rofi.svg',
  recolor = true,
  cmd = "rofi -show drun",
  tooltip = "Run Application Launcher"
}

return pi {
  widget = rofi_btn,
  shape = beautiful.rounded_rect_shape or gears.shape.rounded_rect,
  bg = "#00000000",
  -- top = dpi(6),
  -- bottom = dpi(6),
  margins = dpi(6),
}
