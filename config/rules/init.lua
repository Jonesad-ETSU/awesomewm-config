local beautiful = require ('beautiful')
local awful 	= require ('awful')
local gears 	= require ('gears')

client.connect_signal ('manage', function(c)
	
	c:emit_signal(
		'request::activate',
		'mouse::enter',
		{ raise = true }
	)

	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup
	and not c.size_hints.user_position
	and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end

	update_shape(c)
end)

client.connect_signal('property::fullscreen',function(c) update_shape(c) end)

function update_shape(c)
	if c.fullscreen then
		c.shape = gears.shape.rectangle
	else
		c.shape = function (cr, width, height)
			return gears.shape.rounded_rect( cr, width, height, 15 )
		end
	end
end

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = { 
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},

	{ rule_any = {type = { "normal", "dialog" }
		}, properties = { titlebars_enabled = true }
	},
	--
	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Steam",
			"Sxiv",
			"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			"Wpa_gui",
			"veromix",
			"xtightvncviewer"
		},
		-- Note that the name property shown in xprop might be set slightly after creation of the client and the name shown there might not match defined rules here.
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			"ConfigManager",  -- Thunderbird's about:config.
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools
		}
		}, properties = { floating = true }},
	{ rule_any = { class = { "Steam", "Firefox" }}, properties = { titlebars_enabled = false }},
	
	-- Set Firefox to always map on the tag named "2" on screen 1.
--[[	{ rule = { class = "Firefox" },
		properties = { screen = 1, tag = "2" } }, --]]
}
