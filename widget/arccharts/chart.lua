local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local gfs = gears.filesystem
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local wibox = require ('wibox')

local arcchart = function(args)
  local icon = ib {
    image = gfs.get_configuration_dir() .. '/icons/'..(args.image or 'cpu.svg'),
    recolor = true,
    tooltip = "Amount of CPU Utilization (lower is better)"
  }

  local chart = wibox.widget {
    {
      icon,
      margins = dpi(5),
      widget = wibox.container.margin
    },
    -- id = 'bar',
    paddings = dpi(5),
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
      args.cmd or [[mpstat | awk '// {print 100-$13}' | tail -n1]],
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
    -- bg = beautiful.panel_item.highlight,
    margins = 4,
  }

  return pi_chart
end
return arcchart
