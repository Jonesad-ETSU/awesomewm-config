local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.timeout = 5
naughty.config.defaults.margin = dpi(5)
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.position = "bottom"

