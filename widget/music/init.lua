--[[
--      |  Pic   |  Song Name
--      |        |    Album
--      |        |    time
--      << -----------x--------- >> << = back >> = forward --x-- = progressbar 
--]]

local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')

local song = "Song"
local artist = "Artist"

local album_art = wibox.widget {
    image = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    resize = true,
    widget = wibox.widget.imagebox
}

local song_title = wibox.widget {
    markup = "<b>"..song.."</b>",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
} 

local artist_title = wibox.widget {
    markup = "<i>"..artist.."</i>",
    font = beautiful.font,
    align = 'center',
    widget = wibox.widget.textbox
} 

local top = wibox.widget {
    {
        song_title,
        artist_title,
        layout = wibox.layout.fixed.vertical
    },
    widget = wibox.container.place 
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
    forced_width = dpi(100),
    forced_height = dpi(10),
    color = "#00ff00",
    --paddings = 1,
    widget = wibox.widget.progressbar
}

local bottom = wibox.widget {
    back_pic,
    progressbar,
    forward_pic,
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal 
}

return wibox.widget {
    {
        {
            {
                album_art,
                forced_width = dpi(100),
                forced_height = dpi(100),
                shape = gears.shape.rounded_rect,
                shape_clip = true,
                widget = wibox.container.background
            },
            {
                nil,
                top,
                bottom,
                layout = wibox.layout.align.vertical
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(10),
        widget = wibox.container.margin
    },
    shape = gears.shape.rounded_rect,
    bg = "#ff0000",
    widget = wibox.container.background
}
