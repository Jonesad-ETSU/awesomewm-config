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

local vol_text = wibox.widget {
    text = "Hello, World",
    fg = "#FF0000",
    font = beautiful.font,
    widget = wibox.widget.textbox
}

local vol_icon = wibox.widget {
   image = "/home/jonesad/.config/awesome/music.svg",
   resize = true,
   forced_height = dpi(100),
   forced_width = dpi(100),
   placement = awful.placement.centered,
   widget = wibox.widget.imagebox
}

local vol_bar = wibox.widget {
    bar_shape = gears.shape.rounded_rect,
    bar_color = beautiful.border_color,
    bar_height = 3,
    handle_color = beautiful.bg_normal,
    handle_shape = gears.shape.circle,
    handle_border_color = beautiful.bg_normal,
    handle_border_width = 1,
    forced_width = dpi(300),
    forced_height = dpi(20),
    value = 0,
    widget = wibox.widget.slider
}

local vol_popup = awful.popup {
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

vol_popup : setup {
    {
        {
            {
                vol_icon,
                vol_icon,
                vol_icon,
                layout = wibox.layout.fixed.horizontal
            },
            nil,
--            wibox.widget.seperator,
            {
                vol_text,
                vol_bar,
                layout = wibox.layout.fixed.horizontal
            },
            spacing = dpi(10),
            expand = 'none',
            layout = wibox.layout.align.vertical
        },
        margins = dpi(10),
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_rect,
    shape_border_color = "#ff00ff",
    shape_border_width = dpi(2),
    widget = wibox.container.background
}

function update_text ()
    
end

awesome.connect_signal (
    'widget::volpop',
    function()
        awful.spawn.easy_async (
            'pamixer --get-volume',
            function (stdout)
                vol_text.markup = "<i>" .. stdout .. "</i>"
                vol_text.font = beautiful.font
                vol_bar.value = stdout
            end
        )
        vol_popup.visible = true
    end
)

awesome.connect_signal (
    'test_widget::toggle',
    function()
        vol_popup.visible = not vol_popup.visible
    end
)

return vol_popup
