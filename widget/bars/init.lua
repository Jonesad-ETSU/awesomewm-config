local wibox = require ('wibox')
local dpi = require ('beautiful.xresources').apply_dpi
local vol = require ('widget.bars.vol')
local bri = require ('widget.bars.bria')
--local hdd = require ('widget.bars.hdd')

local bars = wibox.widget {
    {
        {
            vol,
            bri,
--            hdd,
            spacing = dpi(3),
            expand = 'none',
            layout = wibox.layout.flex.vertical
        },
        margins = dpi(10),
        widget = wibox.container.margin
    },
    bg = "#ff0000",
    widget = wibox.container.background
}

return bars
