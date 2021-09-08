local awful = require ('awful')
local wibox = require ('wibox')
local naughty = require ('naughty')
local gfs = require ('gears.filesystem')
local recolor = require ('gears.color').recolor_image
local beautiful = require ('beautiful')
local pi    = require ('widget.util.panel_item')

local img = wibox.widget {
	image = recolor(gfs.get_configuration_dir().."/widget/motd/motd.svg","#dddddd"),
	resize = true,
	widget = wibox.widget.imagebox
}

local txt = wibox.widget {
	font   = beautiful.font,
	valign = 'center',
	align  = 'center',
	widget = wibox.widget.textbox
}

--[[local motd = wibox.widget {
	img,
	txt,
	layout = wibox.layout.ratio.horizontal
} 
motd:ajust_ratio(2, .3, .7, 0)--]]
local motd = wibox.widget {
	txt,
	widget = wibox.container.place
}

awful.spawn.easy_async_with_shell (
	"cat /etc/motd",
	function(stdout)
		txt.markup = "<b>"..stdout.."</b>"
	end

)


return pi(motd)
