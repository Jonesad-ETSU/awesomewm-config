local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gfs = require ('gears.filesystem')
local color = require ('gears.color')
local dpi = require ('beautiful.xresources').apply_dpi

local notif_btn = ib {
        image = gfs.get_configuration_dir() .. 'widget/button/notif/notif.svg',
        hide_tooltip = true, 
        cmd = "discord",
}

return pi {
  widget = notif_btn,
  name = "Notif",
  margins = dpi(6),
  ratio = {
    target 	= 2,
    before 	= 0.8,
    at 	        = 0.2,
    after 	= 0
  }
}
