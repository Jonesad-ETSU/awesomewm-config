local naughty = require ('naughty')
local beautiful = require ('beautiful')
-- local gears = require ('gears')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.timeout = 5
naughty.config.defaults.margin = dpi(20)
-- naughty.config.defaults.border_width = dpi(1)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.title = "System Notification"
-- naughty.config.defaulcs.icon = gears.filesystem.get_configuration_dir() .. "/notifications.svg"
naughty.config.defaults.shape = beautiful.rounded_rect_shape
naughty.config.spacing = dpi(5)

naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

