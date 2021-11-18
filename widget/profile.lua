local wibox = require ('wibox')
local beautiful = require ('beautiful')
-- local awful     = require ('awful')
local gears     = require ('gears')
local dpi   = require ('beautiful.xresources').apply_dpi
local pi   = require ('util.panel_item')
local darker   = require ('util.color').darker
local ib   = require ('util.img_button')
-- local naughty = require ('naughty')
local clickable = require ('util.clickable')

local user_name = os.getenv('USER')
local host_name = 'arch'

local profile_img = function()
  if user_name then
    return "/var/lib/AccountsService/icons/" .. user_name .. '.svg'
  else
    return gears.filesystem.get_configuration_dir() .. '/icons/default.svg'
  end
end

local profile_container = wibox.widget {
  -- {
    {
      {
        ib {
          image = profile_img(),
          use_root_dir = true,
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
    },
    widget = wibox.container.place
}

local profile = pi { 
  widget = profile_container,
  spacing = dpi(0),
  name = "<i>@"..user_name.."</i>",
  margins = dpi(8),
  outer = false
}

return clickable(profile)
