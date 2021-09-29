local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local double_click_event_handler = function(event)

	if time_handler then
		--time_handler:stop()
		time_handler = nil
		event()
		return
	end

	time_handler = gears.timer.start_new( .250,
		function()
			time_handler = nil
			return false
		end
	)
end

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
	    double_click_event_handler(function()
		if c.floating then
			c.floating = false
			return
		end
		c.maximized = not c.maximized
		c:raise()
		return
	    end)
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {position = 'top', bg = beautiful.wibar_bg, size = dpi(20)}) : setup {
	{ -- Left
          -- {
            {
              awful.titlebar.widget.closebutton    (c),
              awful.titlebar.widget.maximizedbutton (c),
              awful.titlebar.widget.minimizebutton (c),
              layout = wibox.layout.fixed.horizontal()
            },
            margins = dpi(2),
            widget = wibox.container.margin
          },
	{ -- Middle
	    { -- Title
		align  = "center",
		widget = awful.titlebar.widget.titlewidget(c)
	    },
	    buttons = buttons,
	    layout  = wibox.layout.flex.horizontal
	},
        {
          awful.titlebar.widget.iconwidget(c),
          awful.titlebar.widget.stickybutton(c),
          layout = wibox.layout.fixed.horizontal
        },
	layout = wibox.layout.align.horizontal
      }
end)
