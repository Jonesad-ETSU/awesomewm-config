local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local awestore = require ('awestore')
local clickable = require ('widget.util.clickable')
local beautiful = require ('beautiful')
local naughty = require ('naughty')
local dpi = require ('beautiful.xresources').apply_dpi
local partition = 'home'

--[[
--  options = {
--      init_value = 0,
--      bar_shape,
--      shape,
--      bar_border_color,
--      bar_border_width,
--      min_value,
--      max_value,
--      color,
--      cmd,
--      activate_function,
--      label_text,
--      label_widget
--      anim_duration,
--      anim_easing
--  }
--
--]]
local bar_widget = function make_bar(options)

    local bar = wibox.widget {
        value = 0,
        max_value = 100,
        bar_shape = gears.shape.rounded_bar,
        shape = gears.shape.rounded_bar,
        bar_border_color = "#ff00ff",
        bar_border_width = 1,
        border_width = 2,
        border_color = "#00ffff",
        forced_width = dpi(100),
        forced_height = dpi(1),
        color = "#00ff00",
        --paddings = 1,
        widget = wibox.widget.progressbar
    }

    local pct = wibox.widget {
        markup = 'N/A',
        align = 'center',
        font = beautiful.font,
        widget = wibox.widget.textbox 
    }

    local anim = awestore.tweened(0,{
        duration = 600,
        easing = awestore.linear
    })


    anim:subscribe( 
        function(val)
            bar.value = val
            pct.markup = math.floor(val) .. '%'
        end 
    )


    local cmd
    if options.cmd then
        cmd = options.cmd
    else
        cmd = "brightnessctl i | awk '/Current/ {gsub(\"[()%]\",\"\"); print $4}'"
    end

    awful.spawn.easy_async_with_shell (
        cmd,
        function(stdout)
           anim:set(tonumber(stdout)) 
           pct.markup = stdout..'%'
        end
    )

    local text = wibox.widget {
        markup = '<b>BRI:</b> ',
        align = 'center',
        font = beautiful.font,
        widget = wibox.widget.textbox
    }


    local total = wibox.widget {
        text,
        bar,
        pct,
        horizontal_spacing = dpi(5),
        layout = wibox.layout.fixed.horizontal
    }

    total:connect_signal(
        'activate',
        function()
            if options.activate_function then
                options.activate_function()
            else
                naughty.notify { text = "total test"}
            end
        end
    )

    return total
end

return clickable(bar_widget)
