local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local l = wibox.layout.stack()

local content_views = require ('widget.settings.content_view')
for key,content in pairs(content_views) do

  if tostring(key) == '1' then
    content.widget.visible = true
  else content.widget.visible = false end

  -- Every widget
  awesome.connect_signal('settings::content_view::show', function(view)
    content.widget.visible = (content.view == view)
  end)

  l:add (
    wibox.widget {
      content.widget,
      margins = dpi(25),
      widget = wibox.container.margin
    })  
end

return l
