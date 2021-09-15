local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local naughty = require ('naughty')
local gfs = gears.filesystem
local color = require ('gears.color').recolor_image
local beautiful = require ('beautiful')
local wibox = require ('wibox')

local updates_txt = wibox.widget {
  markup = 'N/A',
  align = 'center',
  font = beautiful.font,
  widget = wibox.widget.textbox
}

local updates_txt_btn = ib {
  widget = updates_txt,
  cmd = [[notify-send "$(checkupdates)"]],
  tooltip = "Number of updates. Click to see the updates."
}

-- local updates_icon = ib {
--   image = color(gfs.get_configuration_dir() .. "/widget/arccharts/home/home.svg","#ffffff"),
--   cmd = "alacritty -e sudo pacman -Syu",
--   tooltip = "Click to update system"
-- }
--
local updates_icon = ib {
  widget = wibox.widget {
    markup = "<b><u>HOME</u></b>",
    font = beautiful.font .. ' 8',
    align = 'center',
    widget = wibox.widget.textbox
  },
  cmd = [[alacritty -e "df ; read -p 'Press Any Key to Continue'"]],
  tooltip = "home partition\nLeft Click ===> Open terminal and display disk usage."
}

local updates = wibox.widget {
  {
    id = 'txt',
    markup = "",
    align = 'center',
    font = beautiful.font,
    widget = wibox.widget.textbox
  },
  updates_icon,
  updates_txt_btn,
  expand = 'center',
  spacing = 3,
  layout = wibox.layout.ratio.vertical
}
updates:ajust_ratio(2,.0,.9,.1)

local chart = wibox.widget {
  
  updates,
  id = 'bar',
  paddings = 10,
  max_value = 100,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 19,
  colors = "#ffffff",
  bg = "#000000",
  thickness = 16,
  widget = wibox.container.arcchart
}

gears.timer {
  timeout = 6007,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell (
      --gfs.get_configuration_dir()..'/widget/updates/check.sh',
      --[[ checkupdates 2>/dev/null | wc -l ]]--,
      [[df 2>/dev/null | grep /home | grep -o '[0-9]*%' | tr -d '%' ]],
      function(out)
        chart.value = tonumber(out)
        updates.txt.markup = out
        -- naughty.notify {text = "Disk "..out}
      end
    )
  end
}:start()

local pi_chart = pi {
  widget = chart,
  shape = gears.shape.circle,
  bg = "#ff00ff",
  margins = 4,
}

return pi_chart
