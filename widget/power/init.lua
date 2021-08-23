pcall (require, "luarocks.loader")

local wibox     = require ('wibox')
local pi        = require ('widget.util.panel_item')
local clickable = require ('widget.util.clickable')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi       = require ('beautiful.xresources').apply_dpi
local bling     = require ('bling')
local naughty   = require ('naughty')

local bat_pct = -1
local l = wibox.layout.flex.horizontal() 

l.fill_space = true

function make_heart_widget (fullness, bat_state)
    local images_dir = gears.filesystem.get_configuration_dir() .. 'widget/power/icons/'
    local colors = { 
	    discharging = "#FF0000",
	    charging = "#00FF00"
    }
    local color
    if bat_state == 'discharging' then
	    color = colors.discharging
    else color = colors.charging end

    return wibox.widget {
        image = gears.color.recolor_image(images_dir .. "heart-" .. fullness .. ".svg", color),
        resize = true,
        widget = wibox.widget.imagebox 
    } 
end

function get_hearts_widget (pct_remaining, status)

    local num_hearts = 5
    local batl = wibox.layout.flex.horizontal()
    batl:fill_space (true)

    local hearts = {
        full  = make_heart_widget('full', status),
        half  = make_heart_widget('half', status),
        empty = make_heart_widget('empty', status),
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
                echo "$power" | awk '/percentage/ {gsub("%",""); print $2}';\
                echo "$power" | awk '/state/ {gsub("%",""); print $2}'
            ]],
            function (stdout, stderr)
                if stdout:match('error') then
                    naughty.notify { text = "Can't read Battery" }
                end

		local lines = {}
		for s in stdout:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end

                local hearts = get_hearts_widget(lines[1],lines[2])
                bat_pct = stdout
                local w = pi (
                    wibox.widget {
                        hearts,
                        layout = wibox.container.place
                    }
                )
                    
                l:reset()
                l:add(w)
            end
        ) 
    end
} : start()

l:connect_signal(
    'activate',
    function()
        naughty.notify {text = "Percentage Remaining: "..string.gsub(bat_pct,"\n"," ")}
    end
)

return clickable(l)
