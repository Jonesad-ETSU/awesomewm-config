local wibox     = require ('wibox')
local gears     = require ('gears')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi

local nw = function(widget)
    return wibox.widget {
        {
            widget,
            margins = dpi(10),
            widget = wibox.container.margin
        },
        --[[bg = beautiful.panel_item.bg,
        shape = beautiful.panel_item.shape,--]]
        bg = "#0000ff",
        shape = gears.shape.rounded_rect,
        shape_border_color = "#aaaaff",
        shape_border_width = dpi(2),
        widget = wibox.container.background
    }
end

return nw
