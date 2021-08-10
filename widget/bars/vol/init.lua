local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local awestore = require ('awestore')
local clickable = require ('widget.util.clickable')
local beautiful = require ('beautiful')
local naughty = require ('naughty')
local dpi = require ('beautiful.xresources').apply_dpi
local partition = 'home'

local bar = wibox.widget {
    value = 0,
    max_value = 100,
    bar_shape = gears.shape.rounded_bar,
    shape = gears.shape.rounded_bar,
    bar_border_color = "#ff00ff",
    bar_border_width = 1,
    border_width = 2,
    border_color = "#00ffff",
    --forced_width = dpi(100),
    --forced_height = dpi(1),
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


local cmd = "echo $(pamixer --get-volume) && echo $(pamixer --get-mute)"

awful.spawn.easy_async_with_shell (
    cmd,
    function(stdout)
        local lines = {}
        for s in stdout:gmatch("[^\r\n]+") do
            table.insert(lines, s)
        end
        local vol = tonumber(lines[1])
        local mute = lines[2]

        anim:set(vol) 
        if mute == 'true' then
            bar.color = "#ff0000"
        else
            bar.color = "#00ff00"
        end
        pct.markup = vol..'%'
    end
)

local text = wibox.widget {
    markup = '<b>VOL:</b> ',
    align = 'center',
    font = beautiful.font,
    widget = wibox.widget.textbox
}


local total = wibox.widget {
    text,
    bar,
    pct,
    horizontal_spacing = dpi(5),
    layout = wibox.layout.flex.horizontal
}

total:connect_signal(
    'activate',
    function()
        naughty.notify { text = "total test"}
    end
)

return clickable(total)
