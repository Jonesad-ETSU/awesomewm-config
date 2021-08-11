local wibox = require ('wibox')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local vol = require ('widget.bars.vol')
local bri = require ('widget.bars.bri')

return pi (
    wibox.widget {
        vol,
        bri,
        spacing = dpi(3),
        expand = 'none',
        layout = wibox.layout.flex.vertical
    }
)

