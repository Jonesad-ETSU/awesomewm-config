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
    -- halign = 'left',
    widget = wibox.container.place
  -- },
  -- nil,
  -- {
  --   -- {
  --     {
  --       markup = '<i>'..user_name..'</i>'..'@'..host_name,
  --       font = beautiful.small_font,
  --       align = 'center',
  --       widget = wibox.widget.textbox
  --     },
  --   --   {
  --   --     markup = '@'..host_name,
  --   --     font = beautiful.font,
  --   --     align = 'right',
  --   --     widget = wibox.widget.textbox
  --   --   },
  --   --   layout = wibox.layout.fixed.horizontal
  --   -- },
  --   valign = 'center',
  --   halign = 'left',
  --   widget = wibox.container.place
  -- },
  -- expand = 'none',
  -- layout = wibox.layout.align.vertical
}

local profile = pi { 
  widget = profile_container,
  spacing = dpi(0),
  name = "<i>@"..user_name.."</i>",
  margins = dpi(8),
  outer = false
}

return clickable(profile)
