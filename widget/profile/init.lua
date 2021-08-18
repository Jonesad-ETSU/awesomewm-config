local wibox = require ('wibox')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local pi   = require ('widget.util.panel_item')
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
            image = gears.filesystem.get_configuration_dir() .. '/widget/profile/profile.svg',
            resize = true,
            widget = wibox.widget.imagebox
        },
        shape = gears.shape.circle,
        shape_clip = true,
        shape_border_width = 1,
        shape_border_color = "#ffffff",
        widget = wibox.container.background
    }

    local profile = pi ( wibox.widget { 
        profile_pic,
        nil,
        layout = wibox.layout.fixed.vertical
    })

    profile:connect_signal(
        'activate',
        function ()
            naughty.notify { text = user_name }
        end
    )

    return clickable(profile)
  
   -- return profile_widget 
--end

--return return_profile_widget
