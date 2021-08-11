local clickable = require ('widget.util.clickable')
local wibox = require ('wibox')
local awful = require ('awful')
local gfs = require ('gears.filesystem')

--[[
--  image function options = {
--      image,
--      bg => background color
--      cmd => command to run when clicking button
--      stdout_cmd => command to run from output of button
--  }
--]]

local button = function (options)

    local image = wibox.widget {
        {
            image = options.image or gfs.get_configuration_dir() .. '/unknown.svg', 
            resize = true,
            widget = wibox.widget.imagebox
        },
        bg = options.bg or '#0000ff',
        widget = wibox.container.background 
    }
    
    image:connect_signal(
        'activate',
        function() 
            awful.spawn.easy_async (
                options.cmd,
                function(stdout)
                    if options.stdout_cmd then
                        options.stdout_cmd()
                    end
                end
            )
        end
    )
    return clickable(image)
end

return button

