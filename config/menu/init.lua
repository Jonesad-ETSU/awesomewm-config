local menubar	= require ('menubar')
local beautiful	= require ('beautiful')
local hotkeys_popup = require ('awful.hotkeys_popup')
local awful	= require ('awful')

myawesomemenu = {
	{ "Manual", terminal .. " -e man awesome" },
	{ "Edit config", editor_cmd .. " " .. awesome.conffile },
	{ "Quit", function() awesome.quit() end },
}

powermenu = {
	{"Suspend", function() awful.spawn({"systemctl", "suspend"}) end },
	{"Lock", function() awful.spawn({"loginctl", "lock-session"}) end },
	{"Restart Awesome", awesome.restart },
	{"Reboot", function() awful.spawn({"systemctl", "reboot"}) end},
	{"Poweroff", function() awful.spawn({"systemctl", "poweroff"}) end},
}

editmenu = {
	{ "Text Editor (".. editor .. ")", editor_cmd },
	{ "Awesome Config", editor_cmd .. ' ' .. awesome.conffile },
	{ "User Directories", editor_cmd .. ' ' .. awesome.conffile .. '../user-dirs.dirs'},
}

utilitymenu = {
	{ "Monitor ("..sysmonitor..")", terminal .. " -e " .. sysmonitor },
	{ "Change Wallpaper", function() awful.spawn.easy_async("nitrogen" ,function() end) end},
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
	{ "Firefox", function() awful.spawn.easy_async("firefox", function() end) end },
	{ "Thunar", function() awful.spawn.easy_async("thunar",function() end) end },
	{ "Steam", function() awful.spawn.easy_async("steam",function() end) end },
	{ "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Terminal", terminal },
	{ "Edit", editmenu },
	{ "Utilities", utilitymenu },
	{ "Power", powermenu }
	}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
	menu = mymainmenu 
})

menubar.utils.terminal = terminal
