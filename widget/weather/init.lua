local wibox = require ('wibox')
local beautiful = require ('beautiful')

local weather_icons = {
    'cloudy' = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'overcast' = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'windy' = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'sunny'  = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'rain'  = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'hail'  = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg',
    'snow'  = '/home/jonesad/Media/Pictures/cat_profile_pic.jpg'
}
local wind_speed = {}
local temperature = {}
local weather_condtions = {}

get_weather()

local today_image = status_image_widget (weather_conditions.1)
local tomorrow_image = status_image_widget (weather_conditions.2)
local today_wind = wind_widget (wind_speed.1) 
local tomorrow_wind = wind_widget (wind_speed.2) 

local today = wibox.widget {
    
}

local tomorrow = wibox.widget {

}

function daily_widget (image, wind, temp, day)
    return wibox.widget {
        {
            markup = '<b>'..day..'</b>',
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        image,
        {
            markup = '<i>'..temp.degrees..' '..temp.type..'</i>',
            font = beautiful.font,
            widget = wibox.widget.textbox 
        },
        {
            markup = 'Wind Speed: '.. wind.speed .. wind.type
            font = beautiful.font,
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.vertical
    }
end

function status_image_widget (status)
    return wibox.widget {
        image = weather_icons[status],
        resize = true,
        widget = wibox.widget.imagebox 
    }
end

function wind_widget (wind)
   return wibox.widget {
        markup = '<i>'.. wind.speed ' ' .. wind.type ..'</i>',
        font = beautiful.font,
        align = 'center',
        widget = wibox.widget.textbox
   } 
end

-- This function is the main thing that needs to to be improved.
function get_weather()
    local jsonString = ''
    weather_conditions.1 = 'sunny'
    weather_conditions.2 = 'rainy'
    temperature.1 = { 
        degrees = 80,
        type = 'F'
    }
    temperature.2 = {
        degrees = 62,
        type = 'F'
    }
    wind_speed.1 = {
        speed = 3,
        type = 'mi'
    }
    wind_speed.2 = {
        speed = 7,
        type = 'mi'
    }
    return jsonString
end

function parse_day(json)

end
