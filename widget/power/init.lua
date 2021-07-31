pcall (require, "luarocks.loader")

local wibox     = require ('wibox')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local awestore  = require ('awestore')
local gears     = require ('gears')
local dpi       = require ('beautiful.xresources').apply_dpi
local bling     = require ('bling')
local naughty   = require ('naughty')
local hidden    = false

local bat_text = wibox.widget {
    markup = "Test",
    align = 'center',
    widget = wibox.widget.textbox,
    font = beautiful.font,
    visible = true,
}

local battery_layout = wibox.layout.align.horizontal()

local battery_widget = wibox.widget {
    nil,
    bat_text,
    nil,
    layout = battery_layout
}

function get_hearts_text (pct_remaining)
    local wholes = math.floor (pct_remaining / 20)
    local bat_str = ""
    for _= 1, wholes, 1 do
        bat_str = bat_str .. 'F'
    end
    
    pct_remaining = pct_remaining - ( wholes * 20 )
    
    if pct_remaining >= 10 then
        bat_str = bat_str .. 'H'
    else
        bat_str = bat_str .. 'E'
    end
   
    for _= 1, 5 - ( wholes + 1 ), 1 do
        bat_str = bat_str .. 'E'
    end
    return bat_str
end

function get_hearts_widget (pct_remaining)
    local wholes = math.floor (pct_remaining / 20)
    local images_dir = gears.filesystem.get_configuration_dir() .. 'widgets/power/icons'

    local new_battery_layout = wibox.layout.fixed.horizontal()

    local test = wibox.widget {
        text = "TEST_FUNC",
        font = beautiful.font,
        align = 'center',
        widget = wibox.widget.textbox
    }

    for i= 1, wholes, 1 do
        new_battery_layout:add( wibox.widget {
            id = 'full heart ' .. i,
            path = images_dir .. "heart-full.svg",
            resize = true,
            widget = wibox.widget.imagebox
        })
    end
    
    pct_remaining = pct_remaining - ( wholes * 20 )
    
    if pct_remaining >= 10 then
        new_battery_layout:add( wibox.widget {
            id = 'half heart ',
            path = images_dir .. "heart-half.svg",
            resize = true,
            widget = wibox.widget.imagebox
        })
    else
        new_battery_layout:add( wibox.widget {
            id = 'empty heart 0',
            path = images_dir .. "heart-empty.svg",
            resize = true,
            widget = wibox.widget.imagebox
        })
    end
   
    for i= 1, 5 - ( wholes + 1 ), 1 do
        new_battery_layout:add( wibox.widget {
            id = 'empty heart ' .. i,
            path = images_dir .. "heart-empty.svg",
            resize = true,
            widget = wibox.widget.imagebox
        })
    end

    local battery_image = wibox.widget {
        nil,
        {
            layout = new_battery_layout,
        },
        nil,
        layout = wibox.layout.align.vertical
    }
    count = 0
    for _ in pairs(new_battery_layout) do count = count + 1 end
    naughty.notify { text = "testing: " .. count }
    --return battery_image
    return test
end

gears.timer {
    timeout = 11,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async_with_shell (
            [[ search=$(upower -e | grep BAT);power=$(upower -i $search);echo "$power" | awk '/percentage/ {gsub("%",""); print $2}'
            ]],
            function (stdout, stderr)
                if stdout:match('error') then
                    naughty.notify { text = "Can't read Battery" }
                end
                --bat_text.markup = get_hearts_text(stdout)
                battery_layout.second = get_hearts_widget(stdout) 
            end
        ) 
    end
} : start()

return battery_widget
