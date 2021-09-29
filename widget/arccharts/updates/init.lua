local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local naughty = require ('naughty')
-- local gfs = gears.filesystem
-- local color = require ('gears.color').recolor_image
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
--   image = color(gfs.get_configuration_dir() .. "/icons/pkg.svg","#ffffff"),
--   cmd = "alacritty -e sudo pacman -Syu",
--   tooltip = "Click to update system"
-- }

local updates_icon = ib {
  widget = wibox.widget {
    markup = "<b><u>UPDATE</u></b>",
    align = 'center',
    font = beautiful.font .." 8",
    widget = wibox.widget.textbox
  },
  cmd = "alacritty -e sudo pacman -Syu",
  tooltip = "Click to update system"
}

local updates = wibox.widget {
  {
    updates_icon,
    updates_txt_btn,
    -- expand = 'center',
    spacing = 3,
    layout = wibox.layout.flex.vertical
  },
  widget = wibox.container.place
}

-- local updates = wibox.widget {
--   updates_icon,
--   updates_txt_btn,
--   expand = 'center',
--   spacing = 3,
--   layout = wibox.layout.ratio.vertical
-- }
-- updates:ajust_ratio(2,.65,.35,0)

local chart = wibox.widget {
  updates,
  id = 'bar',
  paddings = 5,
  max_value = 20,
  start_angle = math.pi/2,
  rounded_edge = true,
  value = 19,
  --colors = "#ffffff",
  colors = {{
    type = 'linear',
    from = {0,0},
    to   = {150,0},
    stops = {{0,"#ededed"},{50,"#aaaa00"}}
  }},
  --bg = "#000000",
  bg = nil,
  thickness = 15,
  widget = wibox.container.arcchart
}

gears.timer {
  timeout = 3583,
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async_with_shell (
      --gfs.get_configuration_dir()..'/widget/updates/check.sh',
      [[ checkupdates 2>/dev/null | wc -l ]],
      function(out)
        chart.value = chart.max_value - out
        updates_txt.markup = "<i>"..out.."</i>"
        naughty.notify {text = out}
      end
    )
  end
}

local pi_chart = pi {
  widget = chart,
  shape = gears.shape.circle,
  --bg = "#ff0000",
  margins = 1,
}

return pi_chart
