local wibox     = require ('wibox') local gears     = require ('gears')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local old_bg

local nw = function(arg)

  local bg_container = wibox.widget {
		--widget = {},
		bg = "#282828",
		shape = arg.shape or gears.shape.rounded_rect,
		--shape_border_color = "#aaaaff",
		shape_border_color = arg.shape_border_color or "#888888",
		shape_border_width = arg.shape_border_width or dpi(1),	
		widget = wibox.container.background
	}

	local w = wibox.widget {
	    {
		    arg.widget,
		    margins = arg.margins or dpi(10),
		    widget = wibox.container.margin
       	    },
	    spacing = arg.spacing or -10,
	    layout = wibox.layout.ratio.vertical
	    --layout = wibox.layout.stack
    	}

	if arg.name then
		w:add(wibox.widget {
			{
				markup = "" .. arg.name,
				font = beautiful.font,
				align = 'center',
				widget = wibox.widget.textbox
			},
			bg = "#888888",
			shape = gears.shape.rounded_rect,
			shape_border_width = dpi(1),
			widget = wibox.container.background
		})
		if arg.ratio then
			w:ajust_ratio(arg.ratio.target, arg.ratio.before, arg.ratio.at, arg.ratio.after)
		else w:ajust_ratio(2,.85,.15,0) end
	else w:ajust_ratio(1,0,1,0) end

	bg_container.widget = w

    bg_container:connect_signal(
	'mouse::enter',
	function()
		if arg.outer then return end
		old_bg = bg_container.bg
		bg_container.bg = "#484848"
		--w.bg = beautiful.panel_item.bg
	end
    )
    bg_container:connect_signal(
	'mouse::leave',
	function()
		if arg.outer then return end
		bg_container.bg = old_bg
		old_bg = nil
	end
    )
    return bg_container
end

return nw
