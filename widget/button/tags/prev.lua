local ib = require ('widget.util.img_button')
local awful = require ('awful')
local fs = require ('gears.filesystem')

local prev_tag = ib {
  image = fs.get_configuration_dir() .. '/icons/tag-prev.svg',
  recolor = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewprev()
  end)
}

return prev_tag
