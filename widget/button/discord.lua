local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local discord_button = ib ({
  image = 'discord.svg',
  recolor = true,
  hide_tooltip = true, 
  cmd = "discord",
})

return pi {
  widget = discord_button,
  shape_border_width = 0,
  margins = dpi(4),
}
