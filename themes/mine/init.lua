local fs  = require ('gears.filesystem')
local theme_dir = fs.get_configuration_dir() .. '/theme'
local beautiful = require ('beautiful')
local gtk = beautiful.gtk

local theme = {}

  theme.icons = theme_dir .. '/icons/'
  theme.font = "Roboto 8"

  theme.black_dark = "#000000"
  theme.black_light = "#aaaaaa"

  theme.gtk = gtk.get_theme_variables()
  if not theme.gtk then
    require('naughty').notify {
      text = "WTF"
    }
  end

return theme
