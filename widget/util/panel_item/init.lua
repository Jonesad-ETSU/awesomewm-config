local wibox     = require ('wibox')
local gears     = require ('gears')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi

local nw = function(widget)
    return wibox.widget {
        {
            widget,
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = {
		type	= 'linear',
		from	= { 0, 0 },
		to 	= { 0, dpi(100)},
		stops	= {{0, '#00aaaa'}, {50, '#0000ff'}}
	},
        shape = gears.shape.rounded_rect,
        shape_border_color = "#aaaaff",
        shape_border_width = dpi(2),
        widget = wibox.container.background
    }
end

return nw
