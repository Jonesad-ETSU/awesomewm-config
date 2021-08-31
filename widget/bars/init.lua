local wibox = require ('wibox')
local awestore = require ('awestore')
local naughty = require ('naughty')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')
local vol = require ('widget.bars.vol')
local bri = require ('widget.bars.bri')
 
local bars = wibox.widget {
	{
		id = "vol",
		vol,
		shape = gears.shape.rounded_bar,
		widget = wibox.container.background
	},
	{
		id = "bri",
		bri,
		shape = gears.shape.rounded_bar,
		widget = wibox.container.background
	},
	spacing = dpi(3),
	layout = wibox.layout.ratio.vertical
}
bars:ajust_ratio(2, .5, .5, 0)

bars.bri.shape = gears.shape.rounded_bar


--[[local zoom = awestore.tweened(0, {
	duration = 200,
	easing = awestore.easing.back_in_out
})

zoom:subscribe( function(v)
		
end)
--]]

for _,w in pairs(bars.children) do
	w:connect_signal(
		'mouse::enter',
		function()
			w.bg = "#ff0000"
			w.shape_border_width = 3
			w.shape_border_color = "#00ff00"
		end
	)
	w:connect_signal(
		'mouse::leave',
		function()
			w.bg = nil
			w.shape_border_width = 0
			w.shape_border_color = nil
		end
	)
end


return pi(bars)
