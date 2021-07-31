pcall (require, "luarocks.loader")

local wibox	= require ('wibox')
local beautiful = require ('beautiful')
local awful 	= require ('awful')
local awestore 	= require ('awestore')
local gears 	= require ('gears')
local dpi	= require ('beautiful.xresources').apply_dpi
local bling 	= require ('bling')

local config 	= require ('config')
local hidden 	= false


local y_down_transition = awestore.tweened(0-config.panel_height, {
	duration = config.panel_anim_len,
	easing = awestore.linear,
})

local x_right_transition = awestore.tweened(0-config.panel_width, {
	duration = config.panel_anim_len,
	easing = awestore.linear,
})

y_down_transition:subscribe(function(posY) info_panel.y = posY end)
x_right_transition:subscribe(function(posX) info_panel.x = posX end)

local info_panel = wibox {
	ontop = true,
	visible = true,
	width = config.panel_width,
	height = config.panel_height,
	x = panel_x,
	y = panel_y,
	bg = beautiful.bg_normal,
	fg = beautiful.foreground,
	shape = gears.shape.rounded_rect
}

local info = wibox.widget {
	homogeneous = true,
	spacing	= dpi(5),
	min_cols_size = 10,
	min_rows_size = 10,
	layout	= wibox.layout.grid,
}
-- Use this function to assign widgets
-- info:add_widget_at()

info_panel : setup {
	info
}

info_panel:connect_signal(
	'button::press',
	function ()
		if not hidden then
			y_down_transition:set(0 - info_panel.height
				+ info_panel.height/config.panel_amt_hidden)
			info_panel:emit_signal('mouse::leave')
		else
			y_down_transition:set(0)
		end
		hidden = not hidden
	end
)
