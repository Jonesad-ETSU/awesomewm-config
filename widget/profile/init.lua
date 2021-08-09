local wibox = require ('wibox')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local naughty = require ('naughty')
local clickable = require ('widget.util.clickable')
local user_name = 'jonesad'

--local return_profile_widget = function ()

--[[
    awful.spawn(
       'whoami',
       callback = function (stdout)
        user_name = stdout
       end
    )
    --]]

    local user = wibox.widget {
        markup = '<i>'..user_name..'</i>',
        font = beautiful.font,
        align = 'center',
        valign = 'bottom',
        forced_height = dpi(10),
        widget = wibox.widget.textbox
    }

    local profile_pic = wibox.widget {
        {
            --[[image = function()
                if user_name then
                    return "/var/lib/AccountsService/icons/" .. user_name .. '.png'
                else
        --            return gears.filesystem.get_configuration_dir() .. 'icons/default.svg'
                    return '/home/jonesad/Media/Pictures/cat_profile_pic.jpg'
                end 
            end,--]]
            image = '/home/'..user_name..'/Media/Pictures/cat_profile_pic.jpg',
            resize = true,
            widget = wibox.widget.imagebox
        },
        shape = gears.shape.circle,
        shape_clip = true,
        shape_border_width = 1,
        shape_border_color = "#ffffff",
        widget = wibox.container.background
    }

    local profile = wibox.widget {
        {
            {
                {
                    user,
                    direction = 'east',
                    widget = wibox.container.rotate
                },
                profile_pic,
                nil,
                layout = wibox.layout.fixed.horizontal
            },
            margins = dpi(5),
            widget = wibox.container.margin
        },
        bg = '#ff0000',
        forced_height = dpi(100),
        forced_width = dpi(100),
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background 
    }

    profile:connect_signal(
        'activate',
        function ()
            naughty.notify { text = user_name }
        end
    )

    return {
       profile = clickable(profile),
       user = user
    }
   -- return profile_widget 
--end

--return return_profile_widget
