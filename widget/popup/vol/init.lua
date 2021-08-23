local gears     = require ('gears')
local wibox     = require ('wibox')
local awful     = require ('awful')
local ib        = require ('widget.util.img_button')
local pi        = require ('widget.util.panel_item')
local gfs       = require ('gears.filesystem')
local dpi       = require ('beautiful.xresources').apply_dpi

local vol_slider = wibox.widget {
    value = 0, 
    bar_shape = gears.shape.rounded_bar,
    bar_height = dpi(25),
    bar_color = "#ffff00",
    handle_color = "#ff00ff",
    handle_shape = gears.shape.rounded_bar,
    handle_border_color = "#ffeedd",
    handle_border_width = dpi(2),
    widget = wibox.widget.slider
}

local vol_icon = wibox.widget {
    image = gfs.get_configuration_dir() .. '/widget/popup/vol/vol.svg', 
    resize = true,
    forced_height = dpi(500),
    forced_width = dpi(500),
    widget = wibox.widget.imagebox
}

local mute_button = pi ( ib ({
    image = gfs.get_configuration_dir() .. '/widget/popup/vol/mute.svg', 
    cmd = "pamixer -t",
}))

local mute = wibox.widget {
	mute_button,
	forced_width = dpi(100),
	forced_height = dpi(100),
	widget = wibox.container.background
}

local vol_widget = pi (
    wibox.widget {
        vol_icon,
        {
            vol_slider,
            mute,
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.fixed.vertical 
    }
)

local vol_popup = awful.popup {
    widget = vol_widget,
    forced_height = dpi(1000),
    forced_width = dpi(600),
    ontop = true,
    visible = true,
    type = 'normal',
    placement = awful.placement.centered
}


function get_vol()
	local vol = 0
    awful.spawn.easy_async_with_shell (
        'pamixer --get-volume',
        function (stdout)
       		vol = stdout 
        end
    )
	return vol
end

vol_slider:connect_signal (
    'property::value',
    awful.spawn.easy_async (
        "pamixer --set-volume " .. vol_slider.value
    ) 
)

return vol_popup
