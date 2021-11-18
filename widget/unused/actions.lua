local gamemode	= require ('widget.button.gamemode')
local powersave	= require ('widget.button.powersave')
local screen 	= require ('widget.button.screen')
local night	= require ('widget.button.night')
local pi	= require ('util.panel_item')
local wibox	= require ('wibox')
local naughty	= require ('naughty')

local actions = wibox.widget {
	screen,
	night,
	gamemode,
	powersave,
	forced_num_rows = 2,
	forced_num_cols = 2,
	homogeneous	= true,
	expand		= true,
	spacing		= 10,
	layout = wibox.layout.grid
}

return pi {
	widget = actions,
        name = "Quick Settings",
	outer = true,
}
