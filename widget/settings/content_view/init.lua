local wibox = require ('wibox')
local beautiful = require ('beautiful')

return {
  {
    -- widget = wibox.widget {
    --   markup = 'General',
    --   font = beautiful.small_font,
    --   align = 'center',
    --   widget = wibox.widget.textbox
    -- },
    view = 'General',
    widget = require ('widget.settings.content_view.general'),
  },
  {
    -- widget = wibox.widget {
    --   markup = 'Display',
    --   font = beautiful.small_font,
    --   align = 'center',
    --   widget = wibox.widget.textbox
    -- },
    widget = require ('widget.settings.content_view.display'),
    view = 'Display'
  },
  {
    widget = wibox.widget {
      markup = 'Audio',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    view = 'Audio'
  },
  -- {
  --   -- widget = require('widget.power'),
  --   widget = require('widget.settings.content_view.general'),
  --   view = 'Connections'
  -- },
}
