local wibox = require ('wibox')
local awful = require ('awful')
local display_layout = require ('layout.settings.content_view.gen_display')
local stack = wibox.layout.stack()

awful.spawn.easy_async_with_shell (
  [[xrandr --listmonitors | awk '{if(NF>=4) print $4}']],
  function(out)
    local t = {}
    for l in stdout:gmatch("[^\r\n]+") do  
      local dl = display_layout { output = l }
      t:insert(dl)
    end
    for i,w in ipairs(t) do
     w.widget.visible = (i == 1) 
     awesome.connect_signal('settings::content_view::displays::show',function(view)
      w.widget.visible = (w.view == view)
     end)
     stack:add({
       w.widget,
       margins = dpi(15),
       widget = wibox.container.margin
     })
    end
)
