local wibox     = require ('wibox')
local pi 	= require ('widget.util.panel_item')
local darker    = require ('widget.util.color').darker
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
        width = beautiful.panel.width,
        height = beautiful.panel.height,
        border_width = beautiful.panel.border_width,
        border_color = beautiful.panel.border_color,
	screen = s,
        shape = beautiful.panel.shape,
        -- shape = function (cr, width, height)
        --     return gears.shape.rounded_rect(cr, width, height, 20)
        -- end,
        fg = beautiful.panel.fg,
        bg = beautiful.panel.bg
        -- bg = beautiful.black_light
    }

    if not side then
      side = beautiful.panel.side
    end

    if side == 'top' then
      awful.placement.top(panel)
    elseif side == 'bottom' then
      awful.placement.bottom(panel)
    else
      awful.placement.top(panel) --Bar not supporting left or right yet.
    end


    local panel_widget = wibox.widget {
      forced_num_rows = 5,
      forced_num_cols = 14,
      homogeneous = true,
      spacing = beautiful.panel.items_spacing,
      expand = 'none',
      layout = wibox.layout.grid
    }

    local anim_show_hide = awestore.tweened(panel.y ,{
        duration = 250,
        easing = awestore.linear
        -- duration = 500,
        -- easing = awestore.easing.back_in_out
    })

    anim_show_hide:subscribe(function(pos) panel.y = pos end)

    --Initialize panel hidden
    if side == 'top' then
      anim_show_hide:set (-panel.height+panel.height/40)
    else
      anim_show_hide:set (
        awful.screen.focused().geometry.height - panel.height/40
      )
    end

    local widgets = require ('widget')
    local systray = wibox.widget {
      {
        id = 'tray',
        widget = wibox.widget.systray
      },
      widget = wibox.container.place
    }
    systray:get_children_by_id('tray')[1]:set_base_size(32)

    systray = pi {
      widget = systray,
      outer = true,
      bg = nil,
      shape = beautiful.rounded_rect_shape,
      margins = 0,
    }
    --widget, row, col, row_span, col_span
    --COL 1
    panel_widget:add_widget_at(widgets.profile,1,1,4,2)
    panel_widget:add_widget_at(widgets.power,5,1,1,2)

    --COL 3
    panel_widget:add_widget_at(widgets.bars,1,3,2,3)
    panel_widget:add_widget_at(widgets.weather,3,3,2,2)
    panel_widget:add_widget_at(widgets.tasklist(s),5,3,1,9)

    --COL 4

    --COL 5

    --COL 6
    panel_widget:add_widget_at(widgets.music,2,6,3,4)
    panel_widget:add_widget_at(widgets.time,1,6,1,4)

    --COL 7

    --COL 8

    --COL 9

    --COL 10
    panel_widget:add_widget_at(widgets.charts,1,10,3,4)
    panel_widget:add_widget_at(wibox.widget {
      {
        --shape = beautiful.rounded_rect_shape,
        thickness = dpi(2),
        color = beautiful.panel_item.bg,
        widget = wibox.widget.separator
      },
      top = dpi(10),
      bottom = dpi(10),
      widget = wibox.container.margin
    },4,10,1,4)
    -- panel_widget:add_widget_at(widgets.motd,4,10,1,4)

    --COL 11

    --COL 12
    --panel_widget:add_widget_at(widgets.actions,1,12,5,2)
    panel_widget:add_widget_at(systray,5,12,1,2)
    
    --COL 13

    --COL 14
    panel_widget:add_widget_at(widgets.right_buttons,1,14,5,1)
    -- panel_widget:add_widget_at(require('widget.button.right-buttons'),1,14,5,1)
    -- panel_widget:add_widget_at(widgets.btn.notif,1,14,1,1)
    -- panel_widget:add_widget_at(widgets.btn.wall,2,14,1,1)
    -- panel_widget:add_widget_at(widgets.btn.files,3,14,1,1)
    -- panel_widget:add_widget_at(widgets.btn.settings,4,14,1,1)
    -- panel_widget:add_widget_at(widgets.btn.power,5,14,1,1)


    local vertical_margins = {}
    if side == 'top' then
      vertical_margins.top = dpi(40)
      vertical_margins.bottom = dpi(10)
    elseif side == 'bottom' then
      vertical_margins.top = dpi(10)
      vertical_margins.bottom = dpi(40)
    else
      vertical_margins.top = 50
      vertical_margins.bottom = 5
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
                  anim_show_hide:set(dpi(-30))
		else
                  anim_show_hide:set(-panel.height+dpi(panel.height/40))
		end
            else
              if hidden then
                anim_show_hide:set (
                  awful.screen.focused().geometry.height - panel.height + 40
                )
              else
                anim_show_hide:set (
                  awful.screen.focused().geometry.height - panel.height/40
                )
              end
	    end
            gears.timer.start_new (
              1, function()
                s.time.visible = hidden
                return false
              end
            )
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
