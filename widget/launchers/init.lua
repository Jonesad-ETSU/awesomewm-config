local rofi	= require ('widget.button.rofi_launcher')
local firefox	= require ('widget.button.firefox')
local discord	= require ('widget.button.discord')
local terminal	= require ('widget.button.terminal')
local gears	= require ('gears')
local pi	= require ('widget.util.panel_item')
local wibox	= require ('wibox')

local launchers = wibox.widget {
	firefox,
	discord,
	terminal,
	rofi,
	forced_num_rows = 1,
	forced_num_cols = 4,
	homogeneous	= true,
	expand		= true,
	spacing		= 2,
	layout = wibox.layout.grid
}

return launchers

--[[return pi {
	widget = launchers,
        margins = 0,
        shape = gears.shape.rounded_bar,
	outer = true,
}--]]
