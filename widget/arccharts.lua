local wibox = require ('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local pi = require ('util.panel_item')
local arcchart = require ('util.arcchart')

return pi {
  widget = wibox.widget {
    layout = wibox.layout.flex.horizontal,
    spacing = 0,
    -- CPU
    arcchart {
      cmd = "mpstat | awk '{if(NF>=13 && $13 ~ /[[:digit:]]/) print 100-$13}'",
      timeout = 2,
      image = 'cpu.svg'
    },
    -- RAM
    arcchart {
      cmd = [[free -m | awk 'NF==7 {print $3/$2*100}']],
      timeout = 1,
      image = 'ram.svg'
    },
  },
  left = dpi(30),
  right = dpi(30),
  margins = dpi(15),
  outer = true,
}
