local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local darker = require ('widget.util.color').darker
local awful = require ('awful')
local gears = require ('gears')
-- local naughty = require ('naughty')
local gfs = gears.filesystem
-- local color = require ('gears.color').recolor_image
-- local darker = require ('widget.util.color').darker
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local wibox = require ('wibox')

local cpu_icon = ib {
  -- widget = wibox.widget {
  --   text = "CPU",
  --   font = beautiful.medium_font,
  --   align = 'center',
  --   widget = wibox.widget.textbox
  -- },
  image = gfs.get_configuration_dir() .. '/icons/cpu.svg',
  recolor = true,
  tooltip = "Amount of CPU Utilization (lower is better)"
}

local chart = wibox.widget {
  cpu_icon,
  id = 'bar',
  paddings = dpi(15),
  max_value = 100,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 5,
  colors = { beautiful.success },
  bg = beautiful.wibar_bg,
  thickness = dpi(10),
  widget = wibox.container.arcchart
}

gears.timer {
  timeout = 7,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell (
      [[mpstat | awk '// {print 100-$13}' | tail -n1]],
      function(out)
        chart.value = math.floor(tonumber(out))
        -- cpu_txt.markup = out
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
