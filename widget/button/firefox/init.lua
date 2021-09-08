local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gears = require ('gears')
local gfs = gears.filesystem
--local color = require ('gears.color')
local dpi = require ('beautiful.xresources').apply_dpi

local firefox_button = ib {
    image = gfs.get_configuration_dir() .. '/widget/button/firefox/firefox.svg',
    cmd = "firefox",
}

local firefox = pi {
  widget = firefox_button,
    --name = "Firefox",
    --margins = dpi(3),
    shape = gears.shape.circle,
    margins = 0,
    ratio = {
	target = 2,
	before = 0.8,
	at     = 0.2,
	after  = 0
    }
}

return firefox


