local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local awestore = require ('awestore')
local dpi = beautiful.xresources.apply_dpi
local wibox = require ('wibox')

local arcchart = function(args)
  local icon = ib {
    image = args.image,
    recolor = true,
    tooltip = "Amount of CPU Utilization (lower is better)"
  }

  local chart = wibox.widget {
    {
      icon,
      margins = dpi(8),
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

  local setter = awestore.tweened ( 0, {
    duration = 250,
    easing = awestore.linear
  })

  setter:subscribe(function(val) chart.value = val end)

  gears.timer {
    timeout = args.timeout or 7,
    call_now = true,
    autostart = true,
    callback = function()
      awful.spawn.easy_async_with_shell (
      args.cmd or [[mpstat | awk '// {print 100-$13}' | tail -n1]],
        function(out)
          setter:set(math.floor(tonumber(out)))
        end
      )
    end
  }:start()

  local pi_chart = pi {
    widget = chart,
    shape = gears.shape.circle,
    margins = dpi(3),
  }

  return pi_chart
end
return arcchart
