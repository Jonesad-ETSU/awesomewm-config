local btn	= require ('widget.util.img_button')
local pi 	= require ('widget.util.panel_item')
local awful	= require ('awful')
local popup	= require ('widget.util.my_popup')
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

	local l = wibox.layout.flex.horizontal
	
	--Adds each tag as a homogenously-spaced column.
	for t in tags do
		naughty.notify { text = "Found a tag"}
		l:add(make_tag_widget(t))
	end	
	naughty.notify { text = "Done searching tags"}
	l:add(imagebox)

	return l
end


return popup(selector)
