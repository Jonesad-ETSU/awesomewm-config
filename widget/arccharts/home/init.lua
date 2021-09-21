local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local darker = require ('widget.util.color').darker
local awful = require ('awful')
local gears = require ('gears')
-- local naughty = require ('naughty')
-- local gfs = gears.filesystem
-- local color = require ('gears.color').recolor_image
local beautiful = require ('beautiful')
local wibox = require ('wibox')

local home_txt = wibox.widget {
  markup = 'N/A',
  align = 'center',
  font = beautiful.font,
  widget = wibox.widget.textbox
}

local home_txt_btn = ib {
  widget = home_txt,
  cmd = [[notify-send "$(checkupdates)"]],
  tooltip = "Number of updates. Click to see the updates."
}

local home_icon = ib {
  widget = wibox.widget {
    markup = "<b><u>HOME</u></b>",
    font = beautiful.font .. ' 8',
    align = 'center',
    widget = wibox.widget.textbox
  },
  cmd = [[alacritty -e "df; read -p 'Press Any Key to EXIT'"]],
  tooltip = "Home partition\nLeft Click ===> Open terminal and display disk usage."
}

local home = wibox.widget {
  {
    id = 'txt',
    markup = "",
    align = 'center',
    font = beautiful.font,
    widget = wibox.widget.textbox
  },
  home_icon,
  home_txt_btn,
  expand = 'center',
  spacing = 3,
  layout = wibox.layout.ratio.vertical
}
home:ajust_ratio(2,.0,.9,.1)

local chart = wibox.widget {
  home,
  id = 'bar',
  paddings = 10,
  max_value = 100,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 19,
  --colors = "#ffffff",
  colors = {{
    type    = 'linear',
    from    = {0,0},
    to      = {150,0},
    stops   = {{0,"#ededed"},{50,"#ffff00"}}
  }},
  --[[border_width = 1,
  border_color = {
    type    = 'linear',
    from    = {0,0},
    to      = {150,0},
    stops   = {{50,"#ededed"},{0,"#ffff00"}}
  },--]]
  --bg = "#000000",
  bg = nil,
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
        chart.value = 100 - tonumber(out)
        home_txt.markup = out
        -- naughty.notify {text = "Disk "..out}
      end
    )
  end
}:start()

local pi_chart = pi {
  widget = chart,
  shape = gears.shape.circle,
  --bg = darker(beautiful.wibar_bg, 10),
  margins = 4,
}

return pi_chart
