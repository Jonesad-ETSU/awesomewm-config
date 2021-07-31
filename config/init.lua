
local awful  	= require ('awful')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

return {
	panel_width	= 1000,
	panel_height	= 250,
	panel_x 		= 1920/2,
	panel_y 		= 0,
	panel_amt_hidden 	= 20,
	panel_anim_len 	= 500,

	default_term  = 'alacritty',
	default_sh	 = 'bash',
	default_web	 = 'firefox',
	default_mail	 = 'evolution',
	default_files = 'nemo',
}

