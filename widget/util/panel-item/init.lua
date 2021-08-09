local wibox     = require ('wibox')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi

local nw = function(widget)
    return wibox.widget {
        {
            widget,
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.panel_item.bg,
        shape = beautiful.panel_item.shape,
        widget = wibox.container.background
    }
end

return nw
