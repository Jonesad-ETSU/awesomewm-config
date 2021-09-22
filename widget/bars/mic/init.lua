local auto_bar = require ('widget.util.bar')
local click = require ('widget.util.clickable')
-- local naughty = require ('naughty')
local gears = require ('gears')
local awful = require ('awful')
local dpi = require ('beautiful.xresources').apply_dpi
-- local awestore = require ('awestore')
local vol_step = 10
local this_name = "mic"

local b = auto_bar {
    name = this_name,
    value = 50,
    tooltip = "Left Click/Scroll Up ==> Raise Volume by "..vol_step
      .. "\nRight Click/Scroll Down ==> Lower Volume by "..vol_step,
    label_text = "<b>MIC:</b>",
    border_width = dpi(1),
    padding = dpi(2),
    color = {
	type 	= 'linear',
	from	= {0,0},
	to	= {100,0},
	stops	= {{0,"#ffffff"},{50,"#ffff00"}}
    },--"#00ff00",
    cmd = [[pamixer --default-source --get-volume ; pamixer --default-source --get-mute]],
    --activate_function = function()
    --    require('widget.popup.vol')
    --end,
    alt_color = "#ff0000",
    alt_check = function (lines)
        if lines[2] == 'true' then --checks if mute
            return true
        else return false
        end
    end ,
    timer = 7,
    elem_spacing = dpi(5),
}

local bar = b.bar
local setter = b.setter

local function chvol(raise)
  if raise then
    awful.spawn( "pamixer --default-source -i "..vol_step )
  else
    awful.spawn( "pamixer --default-source -d "..vol_step )
  end
  awful.spawn.easy_async(
    'pamixer --default-source --get-volume',
    function(out)
      setter:set(tonumber(out))
    end
  )
end

bar = click(bar,gears.table.join (
  awful.button( { }, 1, function()
    chvol(true)
  end),
  awful.button( { }, 2, function()
    awful.spawn('pavucontrol')
  end),
  awful.button( { }, 3, function()
    chvol(false)
  end),
  awful.button( { }, 4, function()
    chvol(true)
  end),
  awful.button( { }, 5, function()
    chvol(false)
  end)
))

return bar
