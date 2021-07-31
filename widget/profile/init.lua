local wibox = require ('wibox')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local user_name = nil

local return_profile_widget = function ()

    awful.spawn.with_shell (
       "whoami",
       function(stdout)
        user_name = stdout
       end
    )

    local profile_pic = wibox.widget {
        image = function()
            if user_name then
                return "/var/lib/AccountsService/icons/" .. user_name
            else
    --            return gears.filesystem.get_configuration_dir() .. 'icons/default.svg'
                return '/home/jonesad/Media/Pictures/cat_profile_pic.jpg'
        end,
        resize = true,
        forced_height = dpi(80),
        forced_width = dpi(80),
        clip_shape = gears.shape.circle,
        widget = wibox.widget.imagebox
    }

    local profile_widget = wibox.widget {
        {
            profile_pic,
            margins = dpi(10), 
            widget = wibox.container.margin
        },
        bg = '#ff0000',
        widget = wibox.container.background 
    }
    
end

return profile_widget
