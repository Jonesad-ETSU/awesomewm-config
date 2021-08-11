local auto_bar = require ('widget.util.bar')
local naughty = require ('naughty')
local gears = require ('gears')
local dpi = require ('beautiful.xresources').apply_dpi
local awestore = require ('awestore')

return auto_bar (
{
    init_value = 0,
    max_value = 100,
    min_value = 0,
    label_text = "<b>BRI:</b>",
    bar_shape = gears.shape.rounded_rect,
    shape = gears.shape.rounded_rect,
    bar_border_color = "#ff00ff",
    bar_border_width = 1,
    border_width = dpi(2),
    border_color = "#00ffff",
    --forced_width = dpi(100),
    --forced_height = dpi(20),
    color = "#00ff00",
    cmd = "brightnessctl i | awk '/Current/ {gsub(\"[()%]\",\"\"); print $4}'",
    activate_function = function()
        naughty.notify { text = "From Caller" }
    end,
    alt_color = "#ff0000",
    alt_check = true --[[function (stdout)
        if tonumber(stdout) > 50 then
           return true 
        else return false
        end
    end}--]] ,
    timer = 11,
    elem_spacing = dpi(5),
    --stack_pct = true,
    --text_fg = "#000000",
    --anim_duration = 1200,
    --anim_easing = awestore.linear
}
)
