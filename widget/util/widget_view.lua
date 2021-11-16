local awful = require ('awful')
local wibox = require ('wibox')
local gears = require ('gears')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi

local t = function(w,s)
  local tester = awful.popup {
    widget = {},
    ontop = true,
    visible = true,
    type = 'normal',
    placement = awful.placement.centered,
    forced_width = dpi(300),
    forced_height = dpi(300),
    shape = gears.shape.rounded_rect,
    bg = beautiful.bg_normal
  }

  tester : setup {
    w,
    layout = wibox.layout.flex.horizontal
  }

  gears.timer.start_new (
    5,
    function()
      tester.visible = not tester.visible    
    end
  )

  return tester
end

return t
