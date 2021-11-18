local wibox = require ('wibox')
-- local awful = require ('awful')
-- local gears = require ('gears')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local settings_widgets = require ('widget.settings')
local popup = require ('util.my_popup')
local toggle = require ('util.toggle')
local naughty = require ('naughty')
local wifi = settings_widgets.wifi

local settings = function(--[[s--]])

  local top_bar = require ('layout.settings.top_bar')
  local side_bar = require ('layout.settings.side_bar')
  local content_view = require ('layout.settings.content_view')

  local settings_box = wibox.widget {
    top_bar,
    {
      id = 'content',
      {
        {
          side_bar,
          shape = beautiful.rounded_rect_shape,
          shape_border_width = beautiful.panel.border_width,
          shape_border_color = beautiful.panel.border_color,
          widget = wibox.container.background
        },
        margins = dpi(10),
        widget = wibox.container.margin
      },
      {
        -- {
          content_view,
        --   shape = beautiful.rounded_rect_shape,
        --   shape_border_width = beautiful.panel.border_width,
        --   shape_border_color = beautiful.panel.border_color,
        --   widget = wibox.container.background
        -- },
        margins = dpi(10),
        widget = wibox.container.margin
      },
      -- content_view,
      layout = wibox.layout.ratio.horizontal
    },
    spacing = dpi(5),
    layout = wibox.layout.ratio.vertical
  }

  settings_box:ajust_ratio(1,0,.1,.9)
  settings_box:get_children_by_id('content')[1]:ajust_ratio(1,0,.3,.7)

  return settings_box
end

return popup(settings(),
{
  width = dpi(600),
  height = dpi(400),
  border_width = beautiful.panel.border_width,
  border_color = beautiful.panel.border_color 
})
