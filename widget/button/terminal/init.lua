local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local terminal_btn = ib {
  image = 'terminal.svg',
  recolor = true,
  cmd = "alacritty",
}

local terminal = pi {
  widget = terminal_btn, 
  -- shape = gears.shape.circle,
  shape_border_width = 0,
  margins = dpi(4),
  -- ratio = {
  --   target = 2,
  --   before = 0.8,
  --   at     = 0.2,
  --   after  = 0
  -- }
}

return terminal
