local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gfs = require ('gears.filesystem')
local recolor = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

local tag_btn = ib {
	image = recolor(gfs.get_configuration_dir() .. '/widget/button/tag_switch/tag.svg','#ffffff'),
	show_widget = "widget.tag_switch",
	tooltip = 'Show tag-switch widget',
}

return pi {
  widget = tag_btn,
  name = "Tags",
  margins = dpi(8),
  ratio = {
    target = 2,
    before = 0.8,
    at	 = 0.2,
    after = 0
  }
}
