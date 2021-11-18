local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local color = require ('gears.color').recolor_image

local firefox_button = ib {
  image = 'firefox.svg',
  recolor = true,
  cmd = "firefox",
}

local firefox = pi {
  widget = firefox_button,
  shape_border_width = 0,
  margins = dpi(3),
}

return firefox


