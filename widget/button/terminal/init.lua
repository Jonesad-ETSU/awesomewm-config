local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local gears = require ('gears')
local gfs = gears.filesystem
local dpi = require ('beautiful.xresources').apply_dpi

local terminal_btn = ib {
  image = gfs.get_configuration_dir() .. 'widget/button/terminal/terminal.svg',
  cmd = "alacritty",
}

local terminal = pi {
  widget = terminal_btn, 
  shape = gears.shape.circle,
  margins = dpi(4),
  ratio = {
    target = 2,
    before = 0.8,
    at     = 0.2,
    after  = 0
  }
}

return terminal
