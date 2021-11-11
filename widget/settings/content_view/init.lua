local wibox = require ('wibox')
local beautiful = require ('beautiful')

return {
  {
    view = 'General',
    widget = require ('widget.settings.content_view.general'),
  },
  {
    widget = require ('widget.settings.content_view.display'),
    view = 'Display'
  },
  {
    widget = require ('widget.settings.content_view.audio'),
    view = 'Audio'
  },
  -- {
  --   -- widget = require('widget.power'),
  --   widget = require('widget.settings.content_view.general'),
  --   view = 'Connections'
  -- },
}
