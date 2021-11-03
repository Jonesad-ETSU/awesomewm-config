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

local updates_icon = ib {
  image = "pkg.svg",
  recolor = true,
  cmd = "alacritty -e sudo pacman -Syu",
  tooltip = "Click to update system"
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
  {
    updates,
    margins = 10,
    widget = wibox.container.margin
  },
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
      [[ checkupdates 2>/dev/null | wc -l ]],
      function(out)
        chart.value = out
        updates.txt.markup = out
        if tonumber(out) > 0 then
          naughty.notify {text = "There are " .. out .. " Packages out of Date. Consider updating your system with `sudo pacman -Syu`"}
        end
      end
    )
  end
}

local pi_chart = pi {
  widget = chart,
  shape = gears.shape.circle,
  bg = "#ff0000",
  margins = 4,
}

return pi {
  widget = pi_chart,
  outer = true,
  margins = 4,
}
