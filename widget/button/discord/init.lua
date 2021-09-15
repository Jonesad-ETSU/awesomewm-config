local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gears = require ('gears')
local gfs = gears.filesystem
local color = require ('gears.color')
local dpi = require ('beautiful.xresources').apply_dpi

local discord_button = ib ({
  image = gfs.get_configuration_dir() .. 'widget/button/discord/discord.svg',
  hide_tooltip = true, 
  cmd = "discord",
})

return pi {
  widget = discord_button,
  --name = "Discord",
  --margins = dpi(3),
  shape = gears.shape.circle,
  margins = dpi(4),
  ratio = {
    target 	= 2,
    before 	= 0.8,
    at 	= 0.2,
    after 	= 0
  }
}
