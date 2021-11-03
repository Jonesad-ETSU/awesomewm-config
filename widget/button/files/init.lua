local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
-- local awful = require ('awful')
-- local gears = require ('gears')
local beautiful = require ('beautiful')
-- local wibox = require ('wibox')

-- local recolor = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

local settings_btn = ib {
  image = 'folder.svg',
  recolor = true,
  cmd = 'nautilus',
  tooltip = 'Open File Explorer',
  -- buttons = gears.table.join(
  --   awful.button ( {} , 1, function() end )
  -- )
}

return pi {
  widget = settings_btn,
  -- shape = gears.shape.rounded_rect,
  margins = dpi(6),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg
  -- name = "Settings",
  -- margins = dpi(8),
  -- ratio = {
  --   target      = 2,
  --   before      = 0.8,
  --   at          = 0.2,
  --   after       = 0
  -- }
}
