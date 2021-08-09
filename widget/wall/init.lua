local awful = require ('awful')
local gears = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local wibox = require ('wibox')
local clickable = require('widget.util.clickable')

local images_dir = gears.filesystem.get_configuration_dir() ..  'widget/wall/' 
local change_wall = wibox.widget {
    {
        image = images_dir .. 'wall.svg',
        resize = true,
        widget = wibox.widget.imagebox    
    },
    bg = "#0000ff",
    forced_width = dpi(50),
    forced_height = dpi(50),
    widget = wibox.container.background
}

change_wall:connect_signal(
    'activate',
    function()
    --This should actually be a widget in the future
       awful.spawn.easy_async (
            [[nitrogen]],
            function() end
       ) 
    end
)

return clickable(change_wall)
