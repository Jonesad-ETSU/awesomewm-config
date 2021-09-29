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

local ram_icon = ib {
  widget = wibox.widget {
    text = "RAM",
    font = beautiful.medium_font,
    align = 'center',
    widget = wibox.widget.textbox
  },
  tooltip = "Amount of RAM Utilization (lower is better)"
}

local chart = wibox.widget {
  ram_icon,
  id = 'bar',
  paddings = 10,
  max_value = 100,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 19,
  --colors = "#ffffff",
  colors = { beautiful.success },
  bg = beautiful.wibar_bg,
  -- colors = {{
  --   type    = 'linear',
  --   from    = {0,0},
  --   to      = {100,0},
  --   stops   = {{0,beautiful.wibar_fg},{2,darker(beautiful.wibar_fg,-50)}}
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
      -- Takes free output, gets usable and total,
      -- divides usable/total and turns that into a percentage
      [[free -m | awk 'NF==7 {print $3/$2*100}']],
      -- [[echo 100]],
      function(out)
        chart.value = math.floor(tonumber(out))
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
