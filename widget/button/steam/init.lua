local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem

local steam_btn = ib {
  image = gfs.get_configuration_dir() .. '/widget/button/steam/steam.svg',
  cmd = "steam-native",
  tooltip = "Runs Steam (native libraries)"
}

return pi {
  widget = steam_btn,
  shape = gears.shape.circle,
  margins = dpi(4),
}
