local beautiful	= require ('beautiful')
local naughty	= require ('naughty')
local gears 	= require ('gears')
local wibox 	= require ('wibox')
local awful 	= require ('awful')

local popup = function (w, options)
	if options == nil then
		options = {}
	end

	local popup_wibox = wibox {
		widget	= w,
		visible	= false,
		ontop	= true,
		splash 	= true,
		type	= 'normal',
		width 	= options.width or 1000,
		height 	= options.height or 500,
		shape	= options.shape or gears.shape.rounded_rect,
		bg	= options.bg or beautiful.background,
		fg	= options.fg or beautiful.fg_normal
	}

	local placement = options.placement or awful.placement.centered
	--naughty.notify { text = "type: " .. type(placement)}
	if type(placement) == "string" then
		local place = awful.placement
		if placement == "centered" then
			place.centered(popup_wibox)
		elseif placement == "top" then
			place.top(popup_wibox)
		elseif placement == "top-right" then
			place.top_right(popup_wibox)
		elseif placement == "top-left" then
			place.top_left(popup_wibox)
		elseif placement == "bottom-left" then
			place.bottom_left(popup_wibox)
		elseif placement == "bottom-right" then
			place.bottom_right(popup_wibox)
		elseif placement == "bottom" then
			place.bottom(popup_wibox)
		elseif placement == "left" then
			place.left(popup_wibox)
		elseif placement == "right" then
			place.right(popup_wibox)
		end
	elseif type(placement) == "table" or type(placement) == "function" then
		placement(popup_wibox)
	end

	local disappear_event = gears.timer {
		timeout = 5,
		callback = function()
			popup_wibox:emit_signal('toggle')
			return false	-- start_new will loop if this returns true
		end
	}

	popup_wibox:connect_signal (
		'toggle',
		function()
			self.visible = not self.visible
			if self.visible then
				disappear_event:start_new()
			end
		end
	)

	return popup_wibox
end

return popup
