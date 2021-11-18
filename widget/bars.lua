local wibox = require ('wibox')
local beautiful = require ('beautiful')
local pi = require ('util.panel_item')
local dpi = beautiful.xresources.apply_dpi
local slider = require ('util.panel_slider')
local fs = require ('gears.filesystem')

local l = wibox.layout.flex.horizontal()
l.spacing = dpi(8)
--l.spacing = 0

for _,w in pairs({
  {
    name = 'vol',
    getter = [[pamixer --get-volume]],
    setter = [[pamixer --set-volume]],
    label = [[VOL:]],
    vertical = true,
    image = 'volume.svg'
  },
  {
    name = 'mic',
    getter = [[pamixer --default-source --get-volume]],
    setter = [[pamixer --default-source --set-volume]],
    label = [[MIC:]],
    vertical = true,
    image = 'mic.svg'
  },
  {
    name = 'bri',
    getter = [[brightnessctl i | awk '/Current/ {gsub("[()%]",""); print $4}']],
    setter = [[brightnessctl s]],
    setter_post = [[%]],
    minimum = 5,
    label = [[BRI:]],
    vertical = true,
    image = 'brightness.svg'
  }
}) do
  l:add (slider(w))
end

return pi {
  widget = l,
  margins = dpi(10),
  outer = true,
}
