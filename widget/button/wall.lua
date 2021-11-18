local ib = require ('util.img_button')
local pi = require ('util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local wall_btn = ib {
  image = 'wall.svg',
  recolor = true,
  hide_tooltip = true,
  cmd = "nitrogen",
}

return pi {
  widget = wall_btn,
  -- shape = gears.shape.rounded_rect,
  margins = dpi(6),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg
}
