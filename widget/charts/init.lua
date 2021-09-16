local wibox = require ('wibox')
local pi = require ('widget.util.panel_item')
local updates = require ('widget.arccharts.updates')
local home = require ('widget.arccharts.home')
local root = require ('widget.arccharts.root')
-- local timer = require ('widget.arccharts.timer')

return pi {
  widget = wibox.widget {
    layout = wibox.layout.flex.horizontal,
    spacing = 3,
    -- forced_num_rows = 2,
    -- forced_num_cols = 3,
    -- expand = 'none',
    updates,
    home,
    root,
    -- timer
  },
  margins = 10,
  outer = true,
}
