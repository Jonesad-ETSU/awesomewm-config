local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local beautiful = require ('beautiful')
local awful = require ('awful')
local dpi = beautiful.xresources.apply_dpi
-- local wibox = require ('wibox')

local next_tag = ib {
  image = 'tag-next.svg',
  recolor = true,
  hide_tooltip = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewnext()
  end)
}

return pi {
  widget = next_tag,
  -- shape = gears.shape.rounded_rect,
  bg = '#00000000',
  -- margins = 0,
  margins = dpi(6)
}
