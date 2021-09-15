--[[
--  The following file is a modified version of the clickable-container module from the-glorious-dotfiles.
--]]
local wibox = require ('wibox')
local awful = require ('awful')
local dpi = require('beautiful.xresources').apply_dpi

local clickable_container = function ( widget, custom_buttons )
    
    local click_widget = wibox.widget {
      nil,
      widget,
      nil,
      layout = wibox.layout.align.horizontal
    }
     -- Old and new widget
    local old_cursor, old_wibox

    -- Mouse hovers on the widget
    click_widget:connect_signal(
        'mouse::enter',
        function()
            -- Hm, no idea how to get the wibox from this signal's arguments...
            local w = mouse.current_wibox
            if w then
                old_cursor, old_wibox = w.cursor, w
                w.cursor = 'hand1'
            end
        end
    )

    -- Mouse leaves the widget
    click_widget:connect_signal(
        'mouse::leave',
        function()
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end
    )

    -- Mouse pressed the widget
    click_widget:connect_signal(
        'button::press',
        function()
            widget:emit_signal("activate")
        end
    )
    
     -- Mouse releases the widget
     click_widget:connect_signal(
        'button::release',
        function()
            widget:emit_signal("deactivate") 
        end
    )

    click_widget:buttons(
    	custom_buttons or 
	awful.button({},1,function()
		click_widget:emit_signal('activate') 
	end))

    return click_widget
end

return clickable_container
