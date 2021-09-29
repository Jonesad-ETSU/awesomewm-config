local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local beautiful = require ('beautiful')
local color = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

return  ib ({
        image = color(gfs.get_configuration_dir() .. 'icons/game.svg',"#ffffff"),
	tooltip = "Toggle Gamemode",
        hide_tooltip = true, 
        cmd = "discord",
	name = "Game",
	margins = dpi(3),
	ratio = {
		target 	= 2,
		before 	= 0.8,
		at 	= 0.2,
		after 	= 0
	}
})
