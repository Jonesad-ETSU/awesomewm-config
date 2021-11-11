local beautiful = require ('beautiful')
local awful 	= require ('awful')
local wibox 	= require ('wibox')
local ib 	= require ('widget.util.img_button')
local pi	= require ('widget.util.panel_item')

local desktop_btn = function (desktop_file)

	local btn
	local parsed_file = parse_desktop_file(desktop_file, btn)

	function parse_desktop_file(f, button)
		
	awful.spawn.easy_async(
		"cat ".. f,
		function(stdout)
			--This needs to parse the file before throwing it in widget
			local file = {
				icon = find(stdout,"Icon"),
				tooltip = find(stdout,"Name") .. "("..
			}
			button = pi ( ib ({	
				image = file.icon,
				tooltip = file.name,
				cmd = file.cmd
			}))
		end
	)
	end

	function find (lines, key)
		--Uses iterator to return first instance of key val pair
		--Hardcoded '=' to handle ini style key=val syntax
		for s in line:gmatch("(.-)("..key.."=)") do
			return s
		end
	end
end

return desktop_btn
