local ib = require ('widget.util.img_button')
-- local beautiful = require ('beautiful')
local awful = require ('awful')
local fs = require ('gears.filesystem')
local wibox = require ('wibox')

local next_tag = ib {
  -- widget = wibox.widget {
  --   image = fs.get_configuration_dir() .. '/icons/tag-next.svg',
  --   resize = true,
  --   widget = wibox.widget.imagebox
  --   -- markup = "->",
  --   -- font = beautiful.font,
  --   -- align = 'center',
  --   -- widget = wibox.widget.textbox
  -- },
  image = fs.get_configuration_dir() .. '/icons/tag-next.svg',
  recolor = true,
  buttons =  awful.button( {}, 1, function()
    awful.tag.viewnext()
  end)
}

return next_tag
