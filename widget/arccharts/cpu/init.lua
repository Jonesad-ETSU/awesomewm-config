local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local darker = require ('widget.util.color').darker
local awful = require ('awful')
local gears = require ('gears')
-- local naughty = require ('naughty')
-- local gfs = gears.filesystem
-- local color = require ('gears.color').recolor_image
local darker = require ('widget.util.color').darker
local beautiful = require ('beautiful')
local wibox = require ('wibox')

local cpu_txt = wibox.widget {
  markup = 'N/A',
  align = 'center',
  font = beautiful.font,
  widget = wibox.widget.textbox
}

local cpu_txt_btn = ib {
  widget = cpu_txt,
  cmd = [[notify-send "$(checkupdates)"]],
  tooltip = "Number of updates. Click to see the updates."
}

local cpu_icon = ib {
  widget = wibox.widget {
    markup = "<b><u>CPU</u></b>",
    font = beautiful.font .. ' 8',
    align = 'center',
    widget = wibox.widget.textbox
  },
  -- cmd = [[alacritty -e "df; read -p 'Press Any Key to EXIT'"]],
  tooltip = "Amount of CPU not Idling"
}

local cpu = wibox.widget {
  {
    id = 'txt',
    markup = "",
    align = 'center',
    font = beautiful.font,
    widget = wibox.widget.textbox
  },
  cpu_icon,
  cpu_txt_btn,
  expand = 'center',
  spacing = 3,
  layout = wibox.layout.ratio.vertical
}
cpu:ajust_ratio(2,.0,.9,.1)

local chart = wibox.widget {
  cpu,
  id = 'bar',
  paddings = 10,
  max_value = 100,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 19,
  color = beautiful.wibar_fg,
  bg = beautiful.wibar_bg,
  -- colors = {{
  --   type    = 'linear',
  --   from    = {0,0},
  --   to      = {150,0},
  --   stops   = {{0, beautiful.wibar_fg},{50,darker(beautiful.wibar_fg,-10)}}
  -- }},
  --[[border_width = 1,
  border_color = {
    type    = 'linear',
    from    = {0,0},
    to      = {150,0},
    stops   = {{50,"#ededed"},{0,"#ffff00"}}
  },--]]
  --bg = "#000000",
  -- bg = nil,
  thickness = 16,
  widget = wibox.container.arcchart
}

gears.timer {
  timeout = 7,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell (
      [[mpstat | awk '// {print 100-$13}' | tail -n1']],
      function(out)
        chart.value = math.floor(tonumber(out))
        cpu_txt.markup = out
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
