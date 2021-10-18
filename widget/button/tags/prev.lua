local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local fs = require ('gears.filesystem')

local prev_tag = ib {
  image = fs.get_configuration_dir() .. '/icons/tag-prev.svg',
  recolor = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewprev()
  end)
}

return pi {
  widget = prev_tag,
  margins = 0,
  bg = '#00000000'
}
