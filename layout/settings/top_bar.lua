local wibox = require ('wibox')
local beautiful = require ('beautiful')

return wibox.widget {
  {
    nil,
    {
      markup = "Settings",
      font = beautiful.medium_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    nil,
    -- {
    --   
    -- },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  },
  shape_border_color = beautiful.border_normal,
  shape_border_width = beautiful.border_width,
  shape = beautiful.rounded_rect_shape,
  bg = beautiful.transparent,
  widget = wibox.container.background
}
