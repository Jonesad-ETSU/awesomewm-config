local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
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
  -- shape = gears.shape.circle,
  shape_border_width = 0,
  margins = dpi(3),
  -- ratio = {
  --     target = 2,
  --     before = 0.8,
  --     at     = 0.2,
  --     after  = 0
  -- }
}

return firefox


