local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require ('awful.hotkeys_popup')
require ('awful.hotkeys_popup.keys')

globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
		{description="show help", group="awesome"}),

	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
		{description = "view previous", group = "tag"}),

	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
		{description = "view next", group = "tag"}),

	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
		{description = "go back", group = "tag"}),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
		{description = "show main menu", group = "awesome"}),

-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(1)    end,
		{description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(-1)    end,
		{description = "swap with previous client by index", group = "client"}),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
		{description = "focus the next screen", group = "screen"}),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
		{description = "focus the previous screen", group = "screen"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),
-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Control"   }, "Delete", awesome.quit,
		{description = "quit awesome", group = "awesome"}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
		{description = "increase master width factor", group = "layout"}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
		{description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
		{description = "increase the number of master clients", group= "layout"}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
		{description = "decrease the number of master clients", group= "layout"}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol(1, nil, true)    end,
		{description = "increase the number of columns", group = "layout"}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
		{description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey,           }, "l", function () awful.layout.inc(1) end,
		{description = "select next", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "l", function () awful.layout.inc(-1) end,
		{description = "select previous", group = "layout"}),
	--awful.key({ modkey }, "t", function () awesome.emit_signal('panel::visibility::toggle') end, function () awesome.emit_signal('panel::visibility::toggle') end,
	--	{description = "Shows the panel", group = "layout"}),

	awful.key({ modkey, "Control" }, "n",
	    function ()
		      	local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", {raise = true})
			end
		end,
		{description = "restore minimized", group = "client"}),

-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = "launcher"}),

	--[[awful.key({ modkey }, "x",
		function ()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{description = "lua execute prompt", group = "awesome"}),--]] --Don't really understand why this is here
-- Menubar
	awful.key({ modkey }, "p", function() awful.spawn.easy_async("rofi -show drun -show-icons", function() end) end,
		{description = "show the Run Launcher", group = "launcher"}),
	awful.key({ modkey }, "space", function() awful.spawn.easy_async("rofi -show drun -show-icons", function() end) end,
		{description = "show the Run Launcher", group = "launcher"}),
                awful.key({ modkey }, "Tab", function() awful.menu.clients()--[[awful.spawn.easy_async("rofi -show window -show-icons"]] end,
		{description = "switch between all windows", group = "launcher"}),
	awful.key({ "Mod1" }, "Tab", function() awful.menu.client_list()--[[awful.spawn.easy_async("rofi -show windowcd -show-icons", function() end)]] end,

		{description = "switch between Windows on Current Desktop", group = "launcher"}),
-- Change Wallpaper
	awful.key({ modkey, }, "Home",
		function()
			awful.spawn ({"/usr/bin/nitrogen", "--set-auto", "--random"})
		end ,
		{ description = "Changes the wallpaper to a random wallpaper", group = "layout" })

)

for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		--View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"}))
		end
root.keys(globalkeys)
