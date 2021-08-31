local wibox     = require ('wibox')
local gears     = require ('gears')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local old_bg

local nw = function(widget, outer)
    local w = wibox.widget {
	{
            widget,
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = {
		type	= 'linear',
		from	= { 0, 0 },
		to 	= { 0, dpi(100)},
		--stops	= {{0, '#00aaaa'}, {50, '#0088ff'}} --blue
		stops	= {{0, '#282828'}, {50, '#3A3A3A'}}
	},
        shape = gears.shape.rounded_rect,
        --shape_border_color = "#aaaaff",
        shape_border_color = "#888888",
        shape_border_width = dpi(1),
        widget = wibox.container.background
    }
    w:connect_signal(
	'mouse::enter',
	function()
		if outer then return end
		old_bg = w.bg
		w.bg = "#ff0000"
	end
    )
    w:connect_signal(
	'mouse::leave',
	function()
		if outer then return end
		w.bg = old_bg
		old_bg = nil
	end
    )
    return w
end

return nw
