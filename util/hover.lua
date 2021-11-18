local wibox = require ('wibox')
local awful = require ('awful')

local hover_container = function ( widget )
  local old_cursor, old_wibox

  widget:connect_signal (
    'mouse::enter',
    function()
      local w = mouse.current_wibox
      if w then
        old_cursor, old_wibox = w.cursor, w
        w.cursor = 'hand1'
      end
    end
  )

  widget:connect_signal (
    'mouse::leave',
    function()
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
      end
    end
  )
  return widget
end

return hover_container
