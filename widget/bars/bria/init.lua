local auto_bar = require ('widget.util.bar')
local naughty = require ('naughty')
local gears = require ('gears')
local dpi = require ('beautiful.xresources').apply_dpi
local awestore = require ('awestore')

return auto_bar ({
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
    color = "#00ff00",
    cmd = "brightnessctl i | awk '/Current/ {gsub(\"[()%]\",\"\"); print $4}'",
    alt_color = "#ffffff",
    timer = 11,
    elem_spacing = dpi(5),
    anim_duration = 600,
    anim_easing = awestore.linear,
    activate_function = function()
        naughty.notify { text = "From Caller" }
    end,
    alt_check = function (lines)
        if tonumber(lines[1]) > 90 then
           return true 
        else return false end
    end,
})
