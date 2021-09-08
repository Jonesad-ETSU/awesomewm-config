local auto_bar = require ('widget.util.bar')
local naughty = require ('naughty')
local gears = require ('gears')
local awful = require ('awful')
local dpi = require ('beautiful.xresources').apply_dpi
local awestore = require ('awestore')

local step = "10%"  
local my_cmd = "brightnessctl i | awk '/Current/ {gsub(\"[()%]\",\"\"); print $4}'"

return auto_bar ({
    name = "bri",
    init_value = 0,
    max_value = 100,
    min_value = 0,
    label_text = "<b>BRI:</b>",
    bar_border_color = "#888888",
    bar_border_width = 1,
    border_width = dpi(1),
    border_color = "#00ffff",
    color = {
	type 	= 'linear',
	from 	= {0,0},
	to 	= {100,0},
	stops 	= {{0,"#bbbbbb"},{100, "#00ffff"}}
    },--"#00ff00",
    cmd = my_cmd, 
    alt_color = "#ffffff",
    timer = 11,
    elem_spacing = dpi(5),
    anim_duration = 600,
    anim_easing = awestore.linear,
    alt_check = function (lines)
        if tonumber(lines[1]) > 90 then
           return true 
        else return false end
    end,
    buttons = gears.table.join (
	awful.button( { }, 1, function()
		awful.spawn ("brightnessctl s +"..step)	
	end),
	awful.button( { }, 3, function()
		awful.spawn.easy_async_with_shell ("if [ $("..my_cmd..") -ge 20 ]; then brightnessctl s "..step.."-; fi", function() end)	
	end),
	awful.button( { }, 4, function()
		awful.spawn ("brightnessctl s +"..step)	
	end),
	awful.button( { }, 5, function()
		awful.spawn.easy_async_with_shell ("if [ $("..my_cmd..") -ge 20 ]; then brightnessctl s "..step.."-; fi", function() end)	
	end)	
    )
})
