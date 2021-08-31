local rofi	= require ('widget.button.rofi_launcher')
local firefox	= require ('widget.button.firefox')
local discord	= require ('widget.button.discord')
local terminal	= require ('widget.button.terminal')
local pi	= require ('widget.util.panel_item')
local wibox	= require ('wibox')
local naughty	= require ('naughty')

local launchers = wibox.widget {
	firefox,
	discord,
	terminal,
	rofi,
	forced_num_rows = 2,
	forced_num_cols = 2,
	homogeneous	= true,
	expand		= true,
	spacing		= 10,
	layout = wibox.layout.grid
}

return pi(launchers, true)
