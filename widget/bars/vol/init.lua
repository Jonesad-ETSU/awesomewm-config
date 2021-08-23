local auto_bar = require ('widget.util.bar')
local naughty = require ('naughty')
local gears = require ('gears')
local dpi = require ('beautiful.xresources').apply_dpi
local awestore = require ('awestore')

return auto_bar (
{
    label_text = "<b>VOL:</b>",
    bar_shape = gears.shape.rounded_rect,
    shape = gears.shape.rounded_rect,
    bar_border_color = "#ff00ff",
    bar_border_width = 1,
    border_width = dpi(2),
    border_color = "#00ffff",
    --color = "#00ff00",
    --[[color = {
	type = 'linear',
	from = { 0, 0 },
	to = { 0, dpi(300) },
	stops = {{0, "#00FF00"},{dpi(300), "#FF0000"}},
    }--]]
    cmd = [[echo "$(pamixer --get-volume)\n$(pamixer --get-mute)"]],
    activate_function = function()
        require('widget.popup.vol')
    end,
    alt_color = "#ff0000",
    alt_check = function (lines)
        if lines[2] == 'true' then --checks if mute 
            return true 
        else return false
        end
    end ,
    timer = 5,
    elem_spacing = dpi(5),
}
)
