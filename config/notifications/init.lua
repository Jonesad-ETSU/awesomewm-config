local naughty = require ('naughty')
local beautiful = require ('beautiful')
-- local gears = require ('gears')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.timeout = 5
naughty.config.defaults.margin = dpi(20)
-- naughty.config.defaults.border_width = dpi(1)
naughty.config.defaults.border_width = beautiful.border_width
naughty.config.defaults.border_color = beautiful.panel.border_color
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.title = "System Notification"
-- naughty.config.defaulcs.icon = gears.filesystem.get_configuration_dir() .. "/notifications.svg"
naughty.config.defaults.shape = beautiful.rounded_rect_shape
naughty.config.spacing = dpi(5)

naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }
-- naughty.connect_signal(
--   'request::do_not_disturb',
--   function()
--     naughty.suspended = not naughty.suspended  
--     if naughty.suspended then
--       naughty.destroy_all_notifications()
--     end
--   end
-- )

