local wibox = require ('wibox')
local beautiful = require ('beautiful')

return {
  {
    view = 'General',
    label = wibox.widget {
      markup = 'General',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    icon = wibox.widget {
      markup = 'ICON',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    }
  },  
  {
    view = 'Display',
    label = wibox.widget {
      markup = 'Display',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    icon = wibox.widget {
      markup = 'ICON',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    }
  },
  {
    view = 'Connections',
    label = wibox.widget {
      markup = 'Connections',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    icon = wibox.widget {
      markup = 'ICON',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    }
  },  
  {
    view = 'Audio',
    label = wibox.widget {
      markup = 'Audio',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    icon = wibox.widget {
      markup = 'ICON',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    }
  },  
  {
    view = 'Widgets',
    label = wibox.widget {
      markup = 'Widgets',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    },
    icon = wibox.widget {
      markup = 'ICON',
      font = beautiful.small_font,
      align = 'center',
      widget = wibox.widget.textbox
    }
  },  
}
