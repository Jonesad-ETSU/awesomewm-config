local auto_bar = require ('widget.util.bar')
local naughty = require ('naughty')
local gears = require ('gears')
local awful = require ('awful')
local dpi = require ('beautiful.xresources').apply_dpi
local awestore = require ('awestore')
local vol_step = 10
local this_name = "vol"

return auto_bar ({
    name = this_name,
    value = 50,
    label_text = "<b>VOL:</b>",
    --bar_shape = gears.shape.rounded_rect,
    --shape = gears.shape.rounded_rect,
    bar_border_color = "#ff00ff",
    bar_border_width = 1,
    border_width = dpi(2),
    border_color = "#00ffff",
    color = "#00ff00",
    cmd = [[pamixer --get-volume ; pamixer --get-mute]],
    --activate_function = function()
    --    require('widget.popup.vol')
    --end,
    alt_color = "#ff0000",
    alt_check = function (lines)
        if lines[2] == 'true' then --checks if mute 
            return true 
        else return false
        end
    end ,
    timer = 3,
    elem_spacing = dpi(5),
    buttons = gears.table.join(
	awful.button( { }, 1, function()
		awful.spawn( "pamixer -i "..vol_step )
		awesome.emit_signal('widget::util::bar::'..this_name..'::update')
	end),
	awful.button( { }, 2, function()
		awful.spawn( "pamixer -t")
		awesome.emit_signal('widget::util::bar::'..this_name..'::update')
	end),
	awful.button( { }, 3, function()
		awful.spawn( "pamixer -d "..vol_step )
		awesome.emit_signal('widget::util::bar::'..this_name..'::update')
	end),
	awful.button( { }, 4, function()
		awful.spawn( "pamixer -i "..vol_step )
		awesome.emit_signal('widget::util::bar::'..this_name..'::update')
	end),
	awful.button( { }, 5, function()
		awful.spawn( "pamixer -d "..vol_step )
		awesome.emit_signal('widget::util::bar::'..this_name..'::update')
	end)
    )
})
