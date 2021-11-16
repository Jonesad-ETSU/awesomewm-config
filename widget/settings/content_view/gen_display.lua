local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local awful = require ('awful')
local view_it = require ('widget.util.widget_view')
local display_layout = require ('layout.settings.content_view.gen_display')
local stack = wibox.layout.stack()
local test = require ('naughty').notify

test { text = "IN_SETTINGS_CONTENT_VIEW_GEN_DISPLAY"}
awful.spawn.easy_async_with_shell (
  [[xrandr --listmonitors | awk '{if(NF>=4) print $4}']],
  function(out)
    local count = 1
    for l in out:gmatch("[^\r\n]+") do  
      local dl = display_layout { output = l }
      -- dl.widget.visible = false
      awesome.connect_signal('settings::content_view::displays::show',function(v)
        -- require ('naughty').notify { text = "GOT SIGNAL for view: "..v}
        -- require ('naughty').notify { text = "dl.view: "..dl.view}
        dl.widget.visible = (dl.view == v)
        view_it (dl.widget, 5)
      end)
      -- stack:add({
      --   dl.widget,
      --   margins = dpi(15),
      --   widget = wibox.container.margin
      -- })
      stack:add(dl.widget)
      count = count + 1
    end
   end
)

return stack
