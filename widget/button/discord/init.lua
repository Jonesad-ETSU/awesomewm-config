local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
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
  --name = "Discord",
  --margins = dpi(3),
  -- shape = gears.shape.circle,
  shape_border_width = 0,
  margins = dpi(4),
  -- ratio = {
  --   target 	= 2,
  --   before 	= 0.8,
  --   at 	= 0.2,
  --   after 	= 0
  -- }
}
