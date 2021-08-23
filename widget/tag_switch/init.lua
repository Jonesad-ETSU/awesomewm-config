local btn	= require ('widget.util.img_button')
local pi 	= require ('widget.util.panel_item')
local awful	= require ('awful')
local beautiful	= require ('beautiful')
local dpi	= require ('beautiful.xresources').apply_dpi
local wibox	= require ('wibox')
local bling	= require ('bling')

local tags = root.tags()

bling.widget.tag_preview.enable {
	show_client_content = false,
	scale = .25,
	honor_padding = true,
	honor_workarea = true,
	placement_fn = function(c)
		awful.placement.centered(c)
	end
}

local selector = function ()
	local l = wibox.layout.fixed.horizontal
	
	--Adds each tag as a homogenously-spaced column.
	for t in tags do
		l:add(make_tag_widget(t))
	end
	
	local pop = awful.popup {
		widget = {},
		border_width = dpi(3),
		border_color = "#ff00ff",
		forced_width = dpi(500),
		forced_height = dpi(500),
		placement = awful.placement.centered,
		shape = gears.shape.rounded_rect,
		ontop = true,
		type = 'normal',
		visible = true
	}

	pop : setup {
		l
	}



	function make_tag_widget(tag)
		if tag.image then
			local widget = wibox.widget {
				image = tag.image,
				resize = true,
				widget = wibox.widget.imagebox
			}
		else
			local widget = wibox.widget {
				markup = "<b>"..tag.name.."</b>",
				font = beautiful.font,
				align = 'center',
				widget = wibox.widget.textbox
			}
		end
		local widget_btn = pi(widget)

		widget_btn:connect_signal(
			'mouse::hover',
			function()
				awesome.emit_signal('bling::tag_preview::visibility', s, true)		
			end
		)

		widget_btn:connect_signal(
			'mouse::leave',
			function()
				awesome.emit_signal('bling::tag_preview::visibility', s, false)		
			end
		)
		return widget_btn
	end
end


return selector
