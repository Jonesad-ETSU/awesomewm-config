local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local color = require ('gears.color').recolor_image
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem

local steam_btn = ib {
  image = color(gfs.get_configuration_dir() .. '/icons/steam.svg',beautiful.wibar_fg),
  cmd = "steam-native",
  tooltip = "Runs Steam (native libraries)"
}

return pi {
  widget = steam_btn,
  shape = gears.shape.circle,
  shape_border_width = 0,
  margins = dpi(3),
}
