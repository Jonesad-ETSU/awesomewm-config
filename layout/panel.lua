local wibox     = require ('wibox')
local pi 	= require ('widget.util.panel_item')
local awful     = require ('awful')
local gears     = require ('gears')
local awestore  = require ('awestore')
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local hidden    = true
local panel_width = dpi(1000)

local _panel = function(s, side)
    local panel = wibox {
        visible = true,
        ontop = true,
        splash = false,
        width = panel_width,
        height = panel_width/4,
        border_width = 3,
        border_color = "FF00FF",
	screen = s,
        shape = function (cr, width, height)
            return gears.shape.rounded_rect(cr, width, height, 20)
        end,
        fg = beautiful.foreground,
        bg = beautiful.wibar_bg
    }

    if side == 'top' then
      awful.placement.top(panel)
    elseif side == 'bottom' then
      awful.placement.bottom(panel)
    else
      awful.placement.top(panel) --Bar not supporting left or right yet.
    end


    local panel_widget = wibox.widget {
        forced_num_rows = 6,
        forced_num_cols = 14,
        homogeneous = true,
        spacing = dpi(5),
        expand = 'none',
        layout = wibox.layout.grid
    }

    local anim_show_hide = awestore.tweened(panel.y ,{
        duration = 500,
        --easing = awestore.linear
        easing = awestore.easing.back_in_out
    })

    anim_show_hide:subscribe(function(pos) panel.y = pos end)

    --Initialize panel hidden
    if side == 'top' then
      anim_show_hide:set(-panel.height+panel.height/40)
    else
      anim_show_hide:set(
        awful.screen.focused().geometry.height - panel.height/40
      )
    end

    
    local layout_widget = pi {
	    widget = wibox.widget {
		    awful.widget.layoutbox(),
		    widget = wibox.container.place
	    },
	    name = "Layout",
	    margins = dpi(5),
	    ratio = {
		target	= 2,
		before	= 0.8,
		at	= 0.2,
		after	= 0
	    }
    }
    layout_widget:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    local widgets = require ('widget')
    local systray = wibox.widget {
	wibox.widget.systray(),
	widget = wibox.container.place
    }
    systray = pi { 
	    widget = systray,
    	    margins = 0,
	}

    --widget, row, col, row_span, col_span
    --COL 1
    panel_widget:add_widget_at(widgets.profile,1,1,4,2)
    panel_widget:add_widget_at(widgets.power,5,1,2,2)

    --COL 3
    panel_widget:add_widget_at(widgets.bars,1,3,3,3)
    panel_widget:add_widget_at(widgets.btn.tag_switch,4,3,2,1)
    panel_widget:add_widget_at(widgets.launchers, 6, 3, 1, 2)

    --COL 4
    panel_widget:add_widget_at(layout_widget,4,4,2,1)

    --COL 5
    panel_widget:add_widget_at(widgets.weather,4,5,2,2)
    panel_widget:add_widget_at(widgets.tasklist(s),6,5,1,7)

    --COL 6
    panel_widget:add_widget_at(widgets.music,1,6,3,4)

    --COL 7
    panel_widget:add_widget_at(widgets.time,4,7,2,3)

    --COL 8

    --COL 9

    --COL 10
    --[[panel_widget:add_widget_at(wibox.widget {
      widgets.updates,
      widgets.updates,
      widgets.updates,
      widgets.updates,
      expand = 'none',
      forced_num_rows = 2,
      forced_num_cols = 2,
      layout = wibox.layout.grid
    },1,10,5,4)--]]
    panel_widget:add_widget_at(widgets.charts,1,10,5,4)

    --COL 11

    --COL 12
    --panel_widget:add_widget_at(widgets.actions,1,12,5,2)
    panel_widget:add_widget_at(systray,6,12,1,2)
    
    --COL 13

    --COL 14
    panel_widget:add_widget_at(widgets.btn.notif,1,14,2,1)
    panel_widget:add_widget_at(widgets.btn.wall,3,14,2,1)
    panel_widget:add_widget_at(widgets.btn.settings,5,14,2,1)



    local vertical_margins = {}
    if side == 'top' then
      vertical_margins.top = 50
      vertical_margins.bottom = 20
    elseif side == 'bottom' then
      vertical_margins.top = 20
      vertical_margins.bottom = 50
    else
      vertical_margins.top = 50
      vertical_margins.bottom = 20
    end

    panel : setup {
	{
            nil,
            {
                panel_widget,
                top = vertical_margins.top,
                left = 20,
                right = 20,
                bottom = vertical_margins.bottom,
                widget = wibox.container.margin
            },
            nil,
            expand = false,
            layout = wibox.layout.align.horizontal
        },
        layout = wibox.container.place
    }

    awesome.connect_signal (
	'panel::visibility::toggle',
	function()
		panel:emit_signal('toggle')	
	end
    )

    panel:connect_signal (
	'toggle',
	function()        
            if side == 'top' then
		if hidden then
			anim_show_hide:set(-40)
		else
			anim_show_hide:set(-panel.height+panel.height/40)
		end
            else
              if hidden then
                anim_show_hide:set(
                  awful.screen.focused().geometry.height - panel.height + 40
                )
              else
                anim_show_hide:set(
                  awful.screen.focused().geometry.height - panel.height/40
                )
              end
	    end
            hidden = not hidden
      end)

    panel:connect_signal (
        'mouse::enter',
        function ()
		panel:emit_signal('toggle')
        end
    )

    panel:connect_signal (
        'mouse::leave',
        function ()
		panel:emit_signal('toggle')
        end
    )

    return panel
end

return _panel
