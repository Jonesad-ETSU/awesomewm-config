local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local color = require ('gears.color')
local dpi = require ('beautiful.xresources').apply_dpi

return  ib ({
        image = gfs.get_configuration_dir() .. 'widget/button/night/discord.svg',
        hide_tooltip = true, 
        cmd = "",
	name = "Night",
	margins = dpi(3),
	ratio = {
		target 	= 2,
		before 	= 0.8,
		at 	= 0.2,
		after 	= 0
	}
})
