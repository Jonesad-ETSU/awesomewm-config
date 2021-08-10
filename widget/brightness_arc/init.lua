local wibox = require ('wibox')
local gears = require ('gears')
local clickable = require ('widget.util.clickable')
local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local awful = require ('awful')

local pct = 0

local brightness_text = wibox.widget {
    markup = "BRI: ",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
}

local brightness_text_widget = wibox.widget {
    brightness_text,
    margins = 0,
    widget = wibox.container.margin
}

local brightness_arc = wibox.widget {
    brightness_text_widget,
    min_value = 0,
    max_value = 100,
    bg = nil,
    value = pct,
    rounded_edge = true,
    thickness = dpi(10),
    forced_height = dpi(50),
    forced_width = dpi(50),
    start_angle = 0,
    widget = wibox.container.arcchart
}

function get_brightness()
    -- Reads the current screen brightness into pct
    -- Uses easy_async_with_shell as we do not want blocking, and we need the shell for piping
    -- Dependency on brightnessctl
    awful.spawn.easy_async_with_shell(
        [[
        brightnessctl i | awk '/Current/ {gsub("[()%]","");print $4}'
        ]],
        function(stdout)
            brightness_text.markup = "<i>BRI: "..stdout.." </i>"
            brightness_arc.value = stdout
        end
    )
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = function() get_brightness() end
} : start()

brightness_arc:connect_signal(
    'activate',
    function()
        naughty.notify { text = 'test' }
    end
)

return clickable(brightness_arc)
