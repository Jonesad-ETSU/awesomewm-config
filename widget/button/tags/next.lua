local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local beautiful = require ('beautiful')
local awful = require ('awful')
local gears = require ('gears')
-- local dpi = require ('beautiful.xresources').apply_dpi
local fs = gears.filesystem
-- local wibox = require ('wibox')

local next_tag = ib {
  image = fs.get_configuration_dir() .. '/icons/tag-next.svg',
  recolor = true,
  hide_tooltip = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewnext()
  end)
}

return pi {
  widget = next_tag,
  shape = gears.shape.rounded_rect,
  bg = '#00000000',
  margins = 0,
  -- margins = dpi(8)
}
