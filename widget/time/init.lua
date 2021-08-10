local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
local gtk = require ('beautiful.gtk')
local gears = require('gears')
local clickable = require('widget.util.clickable')

local day = wibox.widget {
   markup = "<b>N/A</b>",
   font = "monospace 24",
   align = 'center',
   widget = wibox.widget.textbox 
}

local hour = wibox.widget {
   markup = "<b>N/A</b>",
   --font = beautiful.font,
   font = "monospace 24",
   align = 'center',
   valign = 'center',
   widget = wibox.widget.textbox 
}

local minute = wibox.widget {
   markup = "<b>N/A</b>",
   --font = beautiful.font,
   font = "monospace 24",
   align = 'center',
   valign = 'center',
   widget = wibox.widget.textbox 
}

local time = wibox.widget {
    {
        hour,
        bg = "#00ffff",
        widget = wibox.container.background
    },
    {
        minute,
        bg = "#ffff00",
        widget = wibox.container.background
    },
    layout = wibox.layout.fixed.vertical
}

local date = wibox.widget {
    day,
    time,
    spacing = dpi(0),
    layout = wibox.layout.fixed.vertical
}

function get_day()
    awful.spawn.easy_async_with_shell (
        [[ date '+%a']],
        function(stdout) day.markup = '<b>'..stdout..'</b>' end
    )
end

function get_hour()
    awful.spawn.easy_async_with_shell (
        [[ date '+%H']],
        function(stdout) hour.markup = stdout end
    )
end

function get_minute()
    awful.spawn.easy_async_with_shell (
        [[ date '+%M']],
        function(stdout) minute.markup = stdout end
    )
end

gears.timer {
    timeout = 9973,
    call_now = true,
    autostart = true,
    callback = get_day()
} : start()

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = function()
        get_hour()
        get_minute()
    end
} : start()

date:connect_signal(
    'activate',
    function()
        awful.spawn.easy_async (
        [[date]],
        function(stdout)
            naughty.notify { text = stdout }  
        end
        )
    end
)

return clickable(time)
