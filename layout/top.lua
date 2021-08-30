local wibox     = require ('wibox')
local clickable = require('widget.util.clickable')
local pi 	= require ('widget.util.panel_item')
local awful     = require ('awful')
local gears     = require ('gears')
local awestore  = require ('awestore')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local naughty   = require ('naughty')
local hidden    = true
local panel_width = dpi(1080)

local top = function(s)     
    local panel = wibox {
        visible = true,
        ontop = true,
        splash = false,
        width = panel_width,
        height = panel_width/4,
        border_width = 3,
        border_color = "FF00FF",
        bg = "#2E3440",
	screen = s,
        --x = 240,
        --y = 0,
        shape = function (cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, 20)
        end,
        fg = beautiful.foreground
    }

    awful.placement.top(panel)

    local panel_widget = wibox.widget {
        forced_num_rows = 3,
        forced_num_cols = 14,
        homogeneous = true,
        spacing = dpi(4),
        expand = 'none',
        layout = wibox.layout.grid
    }

    local anim_show_hide = awestore.tweened(panel.y ,{
        duration = 350,
        easing = awestore.linear
    }) 

    anim_show_hide:subscribe(function(pos) panel.y = pos end)

    --Initialize panel hidden
    anim_show_hide:set(-panel.height+panel.height/40)
    
    local layout_widget = pi(awful.widget.layoutbox())
    layout_widget:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))
    local power_widget = require ('widget.power')
    local rofi_widget   = require ('widget.button.rofi_launcher')
    local wall_widget = require ('widget.button.wall')
    local firefox_widget = require ('widget.button.firefox')
    local tag_switch_widget = require ('widget.button.tag_switch')
    local profile_pic = require ('widget.profile')
    local power_btn	= require ('widget.button.power')
    local quick_launchers = require ('widget.launchers')
    local music_widget = require ('widget.music')
    local time_widget = require ('widget.time')
    local bars    = require ('widget.bars')

    --row,col,row_span,col_span
    panel_widget:add_widget_at(power_widget,3,1,1,2)
    --panel_widget:add_widget_at(firefox_widget,2,3,1,1)
    panel_widget:add_widget_at(layout_widget,3,11)
    panel_widget:add_widget_at(quick_launchers, 2, 3, 2, 2)
    panel_widget:add_widget_at(profile_pic,1,1,2,2)
    panel_widget:add_widget_at(music_widget,2,5,2,4)
    panel_widget:add_widget_at(wall_widget,3,10,1,1)
    panel_widget:add_widget_at(tag_switch_widget,3,8,1,1)
    panel_widget:add_widget_at(pi(wibox.container.place(awful.widget.textclock())),3,4,1,4)
    --panel_widget:add_widget_at(rofi_widget,3,3,1,1)
    panel_widget:add_widget_at(bars,1,3,1,3)
    panel_widget:add_widget_at(power_btn,3,14)
    panel_widget:add_widget_at(pi(wibox.widget{
    	wibox.widget.systray(),
	widget = wibox.container.place
	}),3,12,1,2)

    panel : setup {
	{
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
        },
        layout = wibox.container.place
    }

    panel:connect_signal (
        'mouse::enter',
        function ()
            anim_show_hide:set(-40)
            hidden = not hidden    
        end
    )

    panel:connect_signal (
        'mouse::leave',
        function ()
            anim_show_hide:set(-panel.height+panel.height/40)
            hidden = not hidden    
        end
    )

    return panel
end

return top

--end

--return panel

-- DEBUG CODE.
--[[
    local test_widget = require ('widget.test_dont_use_me')
    local test_click = clickable (test_widget)
    local test = wibox.widget {
        {
            id = 'test_widget',
            markup = '<i>This</i> is a <b>TEST</b>',
            align = 'center',
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        bg = beautiful.background,
        widget = wibox.container.background
    }

    local test_background = wibox.widget {
        {
            {
                nil,
                test,
                nil,
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
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
)--]]
