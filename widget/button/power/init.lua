local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local power_btn = ib {
  image = 'switch.svg',
  recolor = true,
  show_widget = "widget.power_popup",
  tooltip       = "Open Shutdown Prompt",
}

return pi {
  widget = power_btn,
  -- shape = gears.shape.rounded_rect,
  -- bg = beautiful.transparent,
  bg = beautiful.panel_item.bg,
  margins = dpi(6)
}
