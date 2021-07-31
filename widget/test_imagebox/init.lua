--animations
pcall (require, "luarocks.loader")
local awestore = require ('awestore')

local awful = require ('awful')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')
local wibox = require ('wibox')
local bling = require ('bling')
local hidden = false

local image = wibox.widget {
    image = "/home/jonesad/Media/Pictures/cat_profile_pic.jpg",
    resize = true,
    placement = awful.placement.centered,
    widget = wibox.widget.imagebox
}

local image_text = wibox.widget {
    markup = "<b>Image =></b>",
    font = beautiful.font,
    widget = wibox.widget.textbox
}

local popup_shape = function (cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 45)
end

local image_popup = awful.popup {
    widget = { },
    ontop = true,
    visible = true,
    type = 'normal',
    x = dpi(200),
    y = dpi(400),
    shape = popup_shape,
    bg = beautiful.bg_normal,
}

image_popup : setup {
    {
        {
            {
                image,
                top = dpi(15),
                widget = wibox.container.margin
            },
            image_text,
            layout = wibox.layout.fixed.horizontal,
            expand = 'none',
            spacing = dpi(2),
        },
        margins = dpi(15),
        widget = wibox.container.margin
    },
    bg = beautiful.background,
    forced_height = dpi(100),
    forced_width = dpi(100),
    widget = wibox.container.background
}

return image_popup
