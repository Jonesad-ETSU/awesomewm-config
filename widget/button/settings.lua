local ib = require ('widget.util.img_button')
local pi = require ('widget.util.panel_item')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local wibox = require ('wibox')

local gfs = gears.filesystem
local dpi = beautiful.xresources.apply_dpi

local settings_btn = ib {
  image = 'settings.svg',
  recolor = true,
  -- widget = wibox.widget {
  --   {
  --     markup = "Settings",
  --     font = beautiful.font ,
  --     align = 'center',
  --     widget = wibox.widget.textbox
  --   },
  --   -- left = dpi(5),
  --   -- right = dpi(5),
  --   widget = wibox.container.margin
  -- },
  show_widget = "layout.settings",
  tooltip = 'Show Settings window',
  buttons = gears.table.join(
    awful.button ( {} , 1, function() end )
  )
}

return pi {
  widget = settings_btn,
  shape = beautiful.rounded_rect_shape,
  -- margins = dpi(5),
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
