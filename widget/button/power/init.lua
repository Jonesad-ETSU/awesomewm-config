local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gfs = require ('gears.filesystem')

local power_btn = ib {
  image = gfs.get_configuration_dir() .. '/widget/button/power/power.svg',
  show_widget = "widget.power_popup",
  tooltip	= "Open Shutdown prompt",
}

return pi {
  widget = power_btn,
  margins = 0
}
