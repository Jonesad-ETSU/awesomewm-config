local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem

local rofi_btn = ib {
  image = gears.color.recolor_image(gfs.get_configuration_dir() .. '/icons/rofi.svg',beautiful.wibar_fg),
  cmd = "rofi -show drun",
  tooltip = "Run Application Launcher"
}

return pi {
  widget = rofi_btn,
  shape = gears.shape.rounded_rect,
  -- top = dpi(6),
  -- bottom = dpi(6),
  margins = dpi(6),
}
