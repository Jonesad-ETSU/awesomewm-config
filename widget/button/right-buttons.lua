local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local pi = require('widget.util.panel_item')
local dpi = beautiful.xresources.apply_dpi

local dir = 'widget.button'
local notify = require(dir..'.notif')
local settings = require(dir..'.settings')
local power = require(dir..'.power')
local files = require(dir..'.files')
local wall = require(dir..'.wall')

return pi {
  widget = wibox.widget {
    -- {
      {
        notify,
        wall,
        files,
        settings,
        power,
        spacing = dpi(5),
        layout = wibox.layout.flex.vertical
      },
      margins = dpi(2),
      widget = wibox.container.margin
    },
  --   shape = gears.shape.rounded_rect,
  --   widget = wibox.container.background
  -- },
  margins = dpi(4),
  outer = true,
}
