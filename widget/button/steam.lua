local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local steam_btn = ib {
  image = 'steam.svg',
  recolor = true,
  cmd = "steam-native",
  tooltip = "Runs Steam (native libraries)"
}

return pi {
  widget = steam_btn,
  -- shape = gears.shape.circle,
  shape_border_width = 0,
  margins = dpi(3),
}
