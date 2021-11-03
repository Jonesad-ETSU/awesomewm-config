local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local dpi = require('beautiful.xresources').apply_dpi

local prev_tag = ib {
  image = 'tag-prev.svg',
  recolor = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewprev()
  end)
}

return pi {
  widget = prev_tag,
  -- margins = 0,
  margins = dpi(6),
  bg = '#00000000'
}
