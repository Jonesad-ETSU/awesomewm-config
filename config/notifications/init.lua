local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.timeout = 5
naughty.config.defaults.margin = dpi(5)
-- naughty.config.defaults.border_width = dpi(1)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.shape = beautiful.rounded_rect_shape
naughty.config.spacing = dpi(10)

naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

