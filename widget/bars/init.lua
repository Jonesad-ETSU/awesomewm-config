local wibox = require ('wibox')
local awestore = require ('awestore')
local lighten = require ('widget.util.color').lighter
local beautiful = require ('beautiful')
local naughty = require ('naughty')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')
local vol = require ('widget.bars.vol')
local mic = require ('widget.bars.mic')
local bri = require ('widget.bars.bri')
 
local bars = wibox.widget {
	{
		id = "vol",
		vol,
		shape = gears.shape.rounded_bar,
		widget = wibox.container.background
	},
	{
		id = "mic",
		mic,
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
	layout = wibox.layout.flex.vertical
}

for _,w in pairs(bars.children) do
	w:connect_signal(
		'mouse::enter',
		function()
--			w.bg = "#ff0000"
			--naughty.notify { text = "wibar_bg: "..beautiful.wibar_bg}			
			w.bg = lighten("#585858", 50)
			w.shape_border_width = 1
			w.shape_border_color = "#888888"
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


return pi {
	widget = bars,
	outer = true,
}
