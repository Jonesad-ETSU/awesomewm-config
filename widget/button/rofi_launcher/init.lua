local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem

local rofi_btn = ib {
  image = gears.color.recolor_image(gfs.get_configuration_dir() .. '/widget/button/rofi_launcher/rofi.svg',"#ffffff"),
  cmd = "rofi -show drun",
  tooltip = "Run Application Launcher"
}

return pi {
  widget = rofi_btn,
  shape = gears.shape.rounded_rect,
  top = dpi(8),
  bottom = dpi(8),
  margins = dpi(4),
}
