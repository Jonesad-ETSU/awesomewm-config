local wibox = require ('wibox')
local awful = require ('awful')
local gfs = require ('gears.filesystem')
local color = require('gears.color').recolor_image
local pi  = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi

local widget = wibox.widget {
	{
		nil,
		{
			image = color(gfs.get_configuration_dir()..'/widget/time/time.svg',"#ffffff"), 
			resize = true,
			widget = wibox.widget.imagebox
		},
		nil,
		expand = 'none',
		layout = wibox.layout.align.vertical
	},
	{
		format = "<span font='DejaVu Sans 16'>%a, %b %d %n %I:%M %p</span>",
		widget = wibox.widget.textclock
	},
	spacing = dpi(10),
	layout = wibox.layout.ratio.horizontal
}
widget:ajust_ratio(2, .3, .7, 0)

return pi(widget)
