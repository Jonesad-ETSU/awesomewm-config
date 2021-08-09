pcall (require, "luarocks.loader")

local wibox	= require ('wibox')
local beautiful = require ('beautiful')
local awful 	= require ('awful')
local awestore 	= require ('awestore')
local gears 	= require ('gears')
local dpi	= require ('beautiful.xresources').apply_dpi
local bling 	= require ('bling')
local naughty	= require ('naughty')
local hidden 	= false

local test = wibox.widget {
	id = 'test_widget',
	markup = '<i>This</i> is a <b>TEST</b>',
--	font = 'scientifica 16',
	font = beautiful.font,
	align = 'center',
	valign = 'center',
	{
---		bg = beautiful.background,
--		fg = '#FF00FF',
		widget = wibox.container.background
	},
	widget = wibox.widget.textbox
}

local vol_test = wibox.widget {
    nil,
    {
        bar_shape	= gears.shape.rounded_rect,
        bar_color	= beautiful.border_color,
        bar_height 	= 3,
        handle_color	= beautiful.bg_normal,
        handle_shape	= gears.shape.circle,
        handle_border_color = beautiful.bg_normal,
        handle_border_width = 1,
        --[[bar_margins	= { left = dpi(30), right = dpi(30), top = dpi(1), bottom = dpi(1) },
        handle_margins	= { left = dpi(3), right = dpi(3), top = dpi(1), bottom = dpi(1) },
        handle_width	= 3,--]]	
        value		= 50,
        widget 		= wibox.widget.slider,
    },
    nil,
    widget = wibox.layout.align.horizontal
}

vol_test:connect_signal(
	'property::value',
	function ()
		awful.spawn.with_shell('pamixer --set-volume ' .. vol_test.value)
	end
) 
local new_shape = function (cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 45)
end

local test_wibox = wibox {
	visible = false,
	ontop = true,
	splash = false,
	width = 200,
	height = 200,
	border_width = 3,
	border_color = "#FFFFFF",
	type = 'normal',
	--x = 100,
	y = 100,
	shape = new_shape,
	bg = beautiful.background,
	fg = beautiful.fg_normal
}
test_wibox.x = -test_wibox.width

local my_tweened = awestore.tweened(test_wibox.x, {
  duration = 250,
  easing = awestore.linear,
})

local my_opacity = awestore.tweened(0, {
  duration = 1000,
  easing = awestore.linear,
})


my_tweened:subscribe(function(v) test_wibox.x = v; end)
--my_tweened:subscribe(function(u) test_wibox.y = u; end)
my_opacity:subscribe(function(o) test_wibox.opacity = o; end)

my_tweened:set(0)
my_opacity:set(1)

test_wibox : setup {
	--layout = wibox.layout.fixed.horizontal,
	layout = wibox.layout.flex.vertical,
	{
		bg = '#000000',
		fg = '#FF00FF',
		widget = wibox.container.background
	},
	expand = 'no',
	spacing = 10,
	test,
	--img_test,
	vol_test
}


local my_tooltip = awful.tooltip {
	mode = 'outside',
	preferred_postitions = { "bottom","right","left","top" },
	objects = { test_wibox, test },
	timeout = 1000,
	timer_function = function()
		if hidden then
			return "<i>CLICK</i> to <b>REVEAL</b> widget"	
		else
			return "<i>CLICK</i> to <b>HIDE</b> widget"	
		end
	end
}

awesome.connect_signal(
	'test_wibox::toggle',
	function ()
		if not test_wibox.visible then
			test_wibox.opacity = 0
			test_wibox.visible = true 
			my_opacity:set(1)
		else 
			my_opacity:set(0)
			test_wibox.visible = false
		end	
	end
)

test_wibox:connect_signal(
--	'button::press',
    'mouse::enter',
    function ()
		if not hidden then 
			my_tweened:set(- test_wibox.width
				+ test_wibox.width/20)
			test_wibox:emit_signal('mouse::leave')
		else
			my_tweened:set(0)
		end
		hidden = not hidden
	end

)

test:connect_signal (
    'activate',
    function () end
)

test:connect_signal (
    'deactivate',
    function () end
)

--[[
test_wibox:connect_signal(
	'mouse::enter',
	function ()
		test_wibox.bg = "#0000FF"
		naughty.notify({
			id = 'click_to_hide',
			title = "Hovering",
			text = "Click to reveal widget",
			timeout = 5
		})
	end
)
--]]
test_wibox:connect_signal(
	'mouse::leave',
	function ()
		test_wibox.bg = "#00FF00"
		naughty.destroy_all_notifications()
	end
)

return test
