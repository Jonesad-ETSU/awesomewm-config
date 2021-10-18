local wibox = require ('wibox')
local beautiful = require ('beautiful')
local pi = require ('widget.util.panel_item')
local dpi = beautiful.xresources.apply_dpi
local slider = require ('widget.util.panel_slider')
local fs = require ('gears.filesystem')

local l = wibox.layout.flex.vertical()
l.spacing = dpi(3)
--l.spacing = 0

for _,w in pairs({
  {
    getter = [[pamixer --get-volume]],
    setter = [[pamixer --set-volume]],
    label = [[VOL:]],
    image = fs.get_configuration_dir() .. '/icons/volume.svg'
  },
  {
    getter = [[pamixer --default-source --get-volume]],
    setter = [[pamixer --default-source --set-volume]],
    label = [[MIC:]],
    image = fs.get_configuration_dir() .. '/icons/mic.svg'
  },
  {
    getter = [[brightnessctl i | awk '/Current/ {gsub("[()%]",""); print $4}']],
    setter = [[brightnessctl s]],
    setter_post = [[%]],
    minimum = 5,
    label = [[BRI:]],
    image = fs.get_configuration_dir() .. '/icons/brightness.svg'
  }
}) do
  l:add (slider(w))
end

return pi {
  widget = l,
  margins = dpi(10),
  outer = true,
}
