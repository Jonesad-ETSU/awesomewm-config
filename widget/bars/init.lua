local wibox = require ('wibox')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local vol = require ('widget.bars.vol')
local mic = require ('widget.bars.mic')
local bri = require ('widget.bars.bri')

local bars = wibox.widget {
  pi {
    widget = vol,
    margins = 0
  },
  pi {
    widget = mic,
    margins = 0,
  },
  pi {
    widget = bri,
    margins = 0,
  },
  spacing = dpi(4),
  layout = wibox.layout.flex.vertical
}

return pi {
  widget = bars,
  margins = dpi(10),
  outer = true,
}
