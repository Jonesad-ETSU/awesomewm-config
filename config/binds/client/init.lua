local awful = require ('awful')
local gears = require ('gears')

clientkeys = gears.table.join (
	awful.key({ modkey,           }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill() end,
		{description = "close", group = "client"}),
	awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle,
		{description = "toggle floating", group = "client"}),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
		{description = "move to master", group = "client"}),
	awful.key({ modkey,           }, "o",      function (c) c:move_to_screen() end,
		{description = "move to screen", group = "client"}),
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end,
		{description = "toggle keep on top", group = "client"}),
	awful.key({ modkey,           }, "n",
		function (c)
			c.minimized = true
		end ,
	{description = "minimize", group = "client"}),
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized = not c.maximizd
			c:raise()
		end ,
	{description = "(un)maximize", group = "client"}),
	awful.key({ modkey, "Control" }, "m",
		function (c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end ,
	{description = "(un)maximize vertically", group = "client"}),
	awful.key({ modkey, "Shift"   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
	{description = "(un)maximize horizontally", group = "client"})
)


clientbuttons = gears.table.join(
	awful.button({ }, 1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end
	),
	awful.button({ modkey }, 1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end
	),
	awful.button({ modkey }, 3,
		function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end
	)
)
--
