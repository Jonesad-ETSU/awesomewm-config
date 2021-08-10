local wibox = require ('wibox')
local gears = require ('gears')
local clickable = require ('widget.util.clickable')
local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local awful = require ('awful')

local pct = 0

local volume_text = wibox.widget {
    markup = "VOL: ",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
}

local volume_text_widget = wibox.widget {
    volume_text,
    margins = 0,
    widget = wibox.container.margin
}

local volume_arc = wibox.widget {
    volume_text_widget,
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

function get_volume()
    -- Reads the current screen volume into pct
    -- Uses easy_async_with_shell as we do not want blocking, and we need the shell for piping
    -- Dependency on volumectl
    awful.spawn.easy_async_with_shell(
        [[ pamixer --get-volume ]],
        function(stdout)
            volume_text.markup = "<i>VOL: "..stdout.." </i>"
            volume_arc.value = stdout
        end
    )
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = function() get_volume() end
} : start()

volume_arc:connect_signal(
    'activate',
    function()
        naughty.notify { text = 'test' }
    end
)

return clickable(volume_arc)
