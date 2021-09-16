local wibox = require ('wibox')
-- local awful = require ('awful')
-- local gears = require ('gears')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local settings_widgets = require ('widget.settings')
local popup = require ('widget.util.my_popup')
local wifi = settings_widgets.wifi

local settings = function(--[[s--]])
  return wibox.widget {
    wifi,
    wifi,
    wifi,
    wifi,
    forced_num_rows = 2,
    forced_num_cols = 2,
    -- layout = wibox.layout.flex.vertical
    expand ='none',
    layout = wibox.layout.grid
  }
end

return popup(settings(),
{
  width = dpi(250),
  height = dpi(400)
})
