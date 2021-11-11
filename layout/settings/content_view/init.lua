local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local l = wibox.layout.stack()

local content_views = require ('widget.settings.content_view')
for key,content in ipairs(content_views) do

  content.widget.visible = (key == 1)
  
  -- Every widget
  awesome.connect_signal('settings::content_view::show', function(view)
    content.widget.visible = (content.view == view)
  end)

  l:add ({
    content.widget,
    margins = dpi(25),
    widget = wibox.container.margin
  })  
end

return l
