local wibox = require ('wibox')
local beautiful = require ('beautiful')
local pi  = require ('widget.util.panel_item')

local widget = wibox.widget {
	{
		format = "<span font='"..beautiful.font.." 14'>%a, %b %d %n %I:%M %p</span>",
		widget = wibox.widget.textclock
	},
	widget = wibox.container.place
}

return pi(widget)
