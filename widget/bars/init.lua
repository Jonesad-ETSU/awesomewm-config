local wibox = require ('wibox')
local awestore = require ('awestore')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local vol = require ('widget.bars.vol')
local bri = require ('widget.bars.bri')

local bars = wibox.widget {
	vol,
	bri,
	spacing = dpi(3),
	--expand = 'none',
	layout = wibox.layout.ratio.vertical
}

local zoom = awestore.tweened(0, {
	duration = 200,
	easing = awestore.easing.back_in_out
})

zoom:subscribe( function(v)
		
end)

vol:connect_signal(
	'mouse::hover',
	function() end
)

bars:ajust_ratio(2, .5, .5, 0)

return pi(bars)
