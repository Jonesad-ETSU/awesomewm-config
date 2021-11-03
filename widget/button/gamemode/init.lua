local ib = require ('widget.util.img_button')
local beautiful = require ('beautiful')
local color = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

return ib {
  image = 'game.svg',
  recolor = true,
  tooltip = "Toggle Gamemode",
  hide_tooltip = true, 
  cmd = "discord"
}
