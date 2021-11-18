local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local pi = require('util.panel_item')
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
      {
        notify,
        wall,
        files,
        settings,
        power,
        spacing_widget = wibox.widget.separator {
          color = beautiful.panel_item.button_bg,
          thickness = dpi(2),
        },
        spacing = dpi(3),
        layout = wibox.layout.flex.vertical
      },
      bg = beautiful.panel_item.button_bg,
      shape = beautiful.rounded_rect_shape,
      widget = wibox.container.background
    },
    margins = dpi(3),
    widget = wibox.container.margin
  },
  --   shape = gears.shape.rounded_rect,
  --   widget = wibox.container.background
  -- },
  margins = dpi(4),
  outer = true,
}
