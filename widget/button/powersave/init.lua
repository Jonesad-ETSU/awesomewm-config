local ib = require ('widget.util.img_button')
local dpi = require ('beautiful.xresources').apply_dpi

return ib {
  image = 'discord.svg',
  recolor = true,
  hide_tooltip = true, 
  cmd = "discord",
  margins = dpi(3),
}
