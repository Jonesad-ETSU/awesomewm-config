pcall (require,'luarocks.loader')

local wibox     = require ('wibox')
local awful     = require ('awful')
local gears     = require ('gears')
local awestore  = require ('awestore')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local naughty   = require ('naughty')
local power_widget = require ('widget.power')
local hidden    = false

--local top_panel = function(s)
    
    local panel_wibox = wibox {
        visible = true,
        ontop = true,
        splash = false,
        width = dpi(1000),
        height = dpi(150),
        border_width = 3,
        border_color = "FF00FF",
        --placement = awful.placement.top,
        x = 240,
        y = -40,
        shape = function (cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, 45)
        end,
        bg = beautiful.background,
        fg = beautiful.foreground
    }

    local panel_widget = wibox.widget {
        forced_num_rows = 3,
        forced_num_cols = 6,
        min_col_size = dpi(10),
        min_row_size = dpi(10),
        homogeneous = false,
        spacing = dpi(4),
        expand = true,
        layout = wibox.layout.grid
    }

    local test_widget = require ('widget.test_dont_use_me')
    local clickable = require('widget.clickable-container')
    local test_click = clickable (test_widget)
    local test = wibox.widget {
        {
            id = 'test_widget',
            markup = '<i>This</i> is a <b>TEST</b>',
            --font = 'scientifica 16',
            align = 'center',
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        bg = beautiful.background,
        --fg = '#FF00FF',
        widget = wibox.container.background
    }

    local test_background = wibox.widget {
        {
            nil,
            test,
            nil,
            layout = wibox.layout.align.horizontal
        },
        bg = "#ff0000",
        fg = "#ffffff",
        shape_border_width = 10,
        shape_border_color = "#0000ff",
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background
    }

    test_background:connect_signal (
        'activate',
        function ()
            naughty.notify { text = "ACTIVATED" }
        end
    )

    panel_widget:add_widget_at(power_widget, 1, 1, 2, 1)
    panel_widget:add_widget_at(test_click, 3, 2, 1, 2)
    panel_widget:add_widget_at(clickable(test_background), 1, 3, 1, 2)
    panel_widget:add_widget_at(test_background, 2, 4, 2, 2)

    panel_wibox : setup {
        nil,
        {
            panel_widget,
            top = 50,
            left = 20,
            right = 20,
            bottom = 20,
            widget = wibox.container.margin
        },
        nil,
        expand = false,
        layout = wibox.layout.align.horizontal
    }

    local anim_show_hide = awestore.tweened(panel_wibox.y ,{
        duration = 500,
        easing = awestore.linear
    }) 

    anim_show_hide:subscribe(function(pos) panel_wibox.y = pos end)

    panel_wibox:connect_signal (
        'mouse::enter',
        function ()
            if hidden then
                anim_show_hide:set(-40)
            else
                anim_show_hide:set(-panel_wibox.height+panel_wibox.height/10)
            end
            hidden = not hidden
        end
    )

--end

return panel_wibox
