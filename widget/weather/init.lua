local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local wibox 	= require ('wibox')
local gears 	= require ('gears')
local gfs 	= require ('gears.filesystem')
local pi	= require ('widget.util.panel_item')

local wind_speed = {}
local temperature = {}
local weather_conditions = {}

-- This function is the main thing that needs to to be improved.
function get_weather()
    local jsonString = ''
    weather_conditions[1] = 'sunny'
    weather_conditions[2] = 'rainy'
    temperature[1] = { 
        degrees = 80,
        type = 'F'
    }
    temperature[2] = {
        degrees = 62,
        type = 'F'
    }
    wind_speed[1] = {
        speed = 3,
        type = 'mi'
    }
    wind_speed[2] = {
        speed = 7,
        type = 'mi'
    }
    return jsonString
end

function status_image_widget (status)
    return wibox.widget {
        --image = weather_icons[status],
        image = gfs.get_configuration_dir() .. '/widget/weather/icons/cloudy.svg',
	resize = true,
        widget = wibox.widget.imagebox 
    }
end

function daily_widget (arg)
    local l = wibox.widget {
	{
		arg.image,
		widget = wibox.container.place
	},
        {
          nil,
          {
            {
              markup = 'Temp: <i>'..arg.temp.degrees..' '..arg.temp.type..'</i>',
              font = beautiful.font,
              widget = wibox.widget.textbox
            },
            {
              markup = 'Wind: '.. arg.wind.speed ..' '.. arg.wind.type,
              font = beautiful.font,
              widget = wibox.widget.textbox
            },
            layout = wibox.layout.fixed.vertical
          },
          nil,
          expand = 'none',
          layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.flex.horizontal
    }
    --l:ajust_ratio(2,.1,.7,.2)
    return l
end

function wind_widget (wind)
   return wibox.widget {
        markup = '<i>'.. wind.speed ' ' .. wind.type ..'</i>',
        font = beautiful.font,
        align = 'center',
        widget = wibox.widget.textbox
   } 
end

function parse_day(json)

end

get_weather()

local today_image = status_image_widget (weather_conditions[2])
--local tomorrow_image = status_image_widget (weather_conditions[2])

local today = daily_widget {
	image = today_image,
	wind = wind_speed[1],
	temp= temperature[1]	
}

--[[local tomorrow = daily_widget (
	tomorrow_image,
	wind_speed[2],
	temperature[2],
	"Tuesday"
)--]]

return pi { 
	widget = today,
	outer = false,
	margins = dpi(2),
}
