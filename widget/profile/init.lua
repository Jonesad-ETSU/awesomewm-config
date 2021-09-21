local wibox = require ('wibox')
local beautiful = require ('beautiful')
-- local awful     = require ('awful')
local gears     = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local pi   = require ('widget.util.panel_item')
local darker   = require ('widget.util.color').darker
local ib   = require ('widget.util.img_button')
-- local naughty = require ('naughty')
local clickable = require ('widget.util.clickable')

local user_name = os.getenv('USER')

local profile_img = function()
  if user_name then
    return "/var/lib/AccountsService/icons/" .. user_name .. '.svg'
  else
    return gears.filesystem.get_configuration_dir() .. '/widget/profile/default.svg'
  end
end

local profile_container = wibox.widget {
  {
    ib {
      image = profile_img(),
      show_widget = 'widget.power_popup',
      tooltip = "opens power menu"
    },
    widget = wibox.container.place
  },
  shape = gears.shape.circle,
  shape_clip = true,
  shape_border_width = dpi(1),
  shape_border_color = darker(beautiful.wibar_bg,-30),
  widget = wibox.container.background
}

local profile = pi { 
  widget = profile_container,
  spacing = dpi(0),
  name = user_name,
  margins = dpi(8),
  outer = false
}

return clickable(profile)
