local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local gfs = gears.filesystem
local recolor = require ('gears.color').recolor_image
local dpi = require ('beautiful.xresources').apply_dpi

local settings_btn = ib {
  image = recolor(gfs.get_configuration_dir() .. '/widget/button/settings/settings.svg','#ffffff'),
  show_widget = "layout.settings",
  tooltip = 'Show Settings window',
  buttons = gears.table.join(
    awful.button ( {} , 1, function() end )
  )
}

return pi {
  widget = settings_btn,
  name = "Settings",
  margins = dpi(8),
  ratio = {
    target      = 2,
    before      = 0.8,
    at          = 0.2,
    after       = 0
  }
}
