local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gears = require ('gears')
local wibox = require ('wibox')
local beautiful = require ('beautiful')
-- local gfs = require ('gears.filesystem')
-- local color = require ('gears.color').recolor_image
local dpi = beautiful.xresources.apply_dpi

local wall_btn = ib {
  -- image = color(gfs.get_configuration_dir() .. 'widget/button/wall/wall.svg',"#ffffff"),
  widget = wibox.widget {
    {
      markup = "<b>Wall</b>",
      font = beautiful.font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    left = dpi(5),
    right = dpi(5),
    widget = wibox.container.margin
  },
  hide_tooltip = true,
  cmd = "nitrogen",
}

return pi {
  widget = wall_btn,
  shape = gears.shape.rectangle,
  margins = 3,
  -- name = "Wall",
  -- margins = 0,
  -- ratio = {
  --   target = 2,
  --   before = 0.8,
  --   at	   = 0.2,
  --   after  = 0
  -- }
}
