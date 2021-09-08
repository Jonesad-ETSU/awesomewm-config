local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')
local pi    = require ('widget.util.panel_item')

local song = "Song"
local artist = "Artist"

local album_art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. '/widget/music/album.png',
    resize = true,
    widget = wibox.widget.imagebox
}

local song_title = wibox.widget {
    markup = "<span font='"..beautiful.font.." 16'><b>"..song.."</b></span>",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
} 

local artist_title = wibox.widget {
    markup = "<span font='"..beautiful.font.." 12'><i>"..artist.."</i></span>",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
} 

local back_pic = wibox.widget {
    markup = "<b>BACK</b>",
    font = beautiful.font,
    widget = wibox.widget.textbox
}

local forward_pic = wibox.widget {
    markup = "<b>FORW</b>",
    font = beautiful.font,
    widget = wibox.widget.textbox
}

local progressbar = wibox.widget {
    value = 33,
    max_value = 100,
    bar_shape = gears.shape.rounded_bar,
    shape = gears.shape.rounded_bar,
    bar_border_color = "#ff00ff",
    bar_border_width = 1,
    border_width = 2,
    border_color = "#00ffff",
    --forced_width = dpi(100),
    forced_height = dpi(10),
    color = "#00ff00",
    --paddings = 1,
    widget = wibox.widget.progressbar
}

local bar_widget = wibox.widget {
    back_pic,
    progressbar,
    forward_pic,
    spacing = dpi(10),
    expand = 'inner',
    layout = wibox.layout.align.horizontal 
}
--[[local bar_widget = wibox.widget {
	bar_widget_,
	bottom = dpi(15),
	widget = wibox.container.margin
}--]]
--bar_widget:ajust_ratio(2,.3,.4,.3)

local main = wibox.widget {
    {
        layout = wibox.layout.align.vertical,
        spacing = dpi(5),
        expand = 'none',
        nil,
        {
            song_title,
            artist_title,
            layout = wibox.layout.fixed.vertical
        },
        bar_widget
    },
    margins = dpi(10),
    widget = wibox.container.margin 
}

local final_widget = wibox.widget {
    {
        album_art,
        shape = gears.shape.rounded_rect,
	shape_border_width = dpi(2),
	--shape_border_width = 0,
	shape_border_color = "#00cccc",
        shape_clip = true,
        widget = wibox.container.background
    },
    main,
    spacing = dpi(10),
    layout = wibox.layout.fixed.horizontal
}

return pi {
	widget = final_widget,
	margins = 0,
	outer = false,
	name = nil,
} 
