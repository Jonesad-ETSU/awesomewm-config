local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gfs = require ('gears.filesystem')
local color = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

local wall_btn = ib {
  image = color(gfs.get_configuration_dir() .. 'widget/button/wall/wall.svg',"#ffffff"),
  hide_tooltip = true,
  cmd = "nitrogen",
}

return pi {
  widget = wall_btn,
  name = "Wall",
  margins = 0,
  ratio = {
    target = 2,
    before = 0.8,
    at	   = 0.2,
    after  = 0
  }
}
