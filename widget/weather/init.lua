local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local wibox 	= require ('wibox')
local naughty 	= require ('naughty')
local awful 	= require ('awful')
local gears 	= require ('gears')
local gfs 	= require ('gears.filesystem')
local pi	= require ('widget.util.panel_item')

-- local wind_speed = {}
-- local temperature = {}
local weather_conditions = {}
local location = "37303"

local function weather_icon (status)
  local icon = gfs.get_configuration_dir().. 'widget/weather/icons/'..(status or '')..'.svg'
  if gears.filesystem.file_readable(icon) then
    return wibox.widget {
      image = gfs.get_configuration_dir() .. 'widget/weather/icons/'..status..'.svg',
      resize = true,
      widget = wibox.widget.imagebox 
    }
  else return wibox.widget {
    markup = "<b>"..(status or '').."</b>",
    font = beautiful.font .. " 32",
    align = 'center',
    widget = wibox.widget.textbox
  } end
end


local function get()

  local temp = wibox.widget {
    markup = 'Temp: <i></i>',
    font = beautiful.font,
    widget = wibox.widget.textbox
  }

  local wind = wibox.widget {
    markup = 'Wind: ',
    font = beautiful.font,
    widget = wibox.widget.textbox
  }

  local icon = wibox.widget {
    image = "",
    resize = true,
    widget = wibox.widget.imagebox
  }

  local dw = wibox.widget {
      {
        icon,
        widget = wibox.container.place
      },
      {
        nil,
        {
          temp,
          wind,
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
      },
      layout = wibox.layout.flex.horizontal
    }

  local cmd = [[curl wttr.in/]]..location..[[?format="%C\n%t\n%w\n"]]
  awful.spawn.easy_async_with_shell ( 
    --cmd,
    'echo "Partly cloudy\n+70°F\n0mph\n"', --Hardcoded value so I can test this at work.
    function(stdout,stderr)
      -- Handles case when curl can't connect.
      -- if stderr:find('%a+') then
      --   return wibox.widget {
      --     markup = "OFFLINE",
      --     font = beautiful.font,
      --     widget = wibox.widget.textbox
      --   }
      -- end

      --naughty.notify {text = "Weather test "..stdout}
      local lines = {}
      for s in stdout:gmatch("[^\r\n]+") do
        naughty.notify {text=s}
        table.insert(lines,s)
      end

      for _,s in ipairs(lines) do
        naughty.notify { text = "Line: "..s}
      end
      naughty.notify {text = "Icon's image: "}

      icon.image = gfs.get_configuration_dir() .. 'widget/weather/icons/'..lines[1]..'.svg'
      naughty.notify {text = "Icon's image: "..icon.image}
      temp.markup = 'TEST '..lines[2]
      wind.markup = 'TEST2 '..lines[3]
      return dw
    end
  )
end


--get_weather()

--local today_image = weather_icon (weather_conditions[2])

--[[today = daily_widget() --[[{
  image_widget = today_image,
  wind = wind_speed[1],
  temp= temperature[1],
}--]]

local today = get()

return pi {
  widget = today,
  outer = false,
  margins = dpi(2),
}
