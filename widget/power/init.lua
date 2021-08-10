--[[
--  I can't figure out how to make this widget clickable using my utility class. May have to manually add this one.
--  But, that means my clickable class needs to learn how to handle this use case ( giving it a layout ). Cursor changes correctly,
--  however it does not get the 'activate' signal like it should (does nothing).
--]]
pcall (require, "luarocks.loader")

local wibox     = require ('wibox')
local clickable = require ('widget.util.clickable')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi       = require ('beautiful.xresources').apply_dpi
local bling     = require ('bling')
local naughty   = require ('naughty')

local l = wibox.layout.fixed.horizontal() 
l.fill_space = true

function make_heart_widget (fullness)
    local images_dir = gears.filesystem.get_configuration_dir() .. 'widget/power/icons/'
    return wibox.widget {
        image = images_dir .. "heart-" .. fullness .. ".svg",
        resize = true,
        widget = wibox.widget.imagebox 
    } 
end

function get_hearts_widget (pct_remaining)

    local num_hearts = 5
    local batl = wibox.layout.flex.horizontal()
    batl:fill_space (true)

    local hearts = {
        full  = make_heart_widget('full'),
        half  = make_heart_widget('half'),
        empty = make_heart_widget('empty'),
    }
    
    local wholes = math.floor (pct_remaining / (100/num_hearts))

    for _ = 1, wholes do batl:add(hearts.full) end
    pct_remaining = pct_remaining - ( wholes * 100/num_hearts )
    
    if pct_remaining >= (100/(2*num_hearts)) then
        batl:add(hearts.half)
    else batl:add(hearts.empty) end
   
    for i= 1, (num_hearts - 1) - wholes, 1 do batl:add(hearts.empty) end

    return batl
end

gears.timer {
    timeout = 11,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async_with_shell (
            [[ 
                search=$(upower -e | grep BAT);\
                power=$(upower -i $search);\
                echo "$power" | awk '/percentage/ {gsub("%",""); print $2}'
            ]],
            function (stdout, stderr)
                if stdout:match('error') then
                    naughty.notify { text = "Can't read Battery" }
                end
                local hearts = get_hearts_widget(stdout)
                local w = wibox.widget {
                    {
                        hearts,
                        layout = wibox.container.place
                    },
                    bg = "#ff0000",
                    widget = wibox.container.background
                }
                    
                l:reset()
                l:add(w)
            end
        ) 
    end
} : start()


return l
