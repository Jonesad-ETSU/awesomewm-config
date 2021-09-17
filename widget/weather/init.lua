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
--local weather_conditions = {}
local location = "37303"
local today

-- local function weather_icon (status)
--   local icon = gfs.get_configuration_dir().. 'widget/weather/icons/'..(status or '')..'.svg'
--   if gears.filesystem.file_readable(icon) then
--     return wibox.widget {
--       image = gfs.get_configuration_dir() .. 'widget/weather/icons/'..status..'.svg',
--       resize = true,
--       widget = wibox.widget.imagebox 
--     }
--   else return wibox.widget {
--     markup = "<b>"..(status or '').."</b>",
--     font = beautiful.font .. " 32",
--     align = 'center',
--     widget = wibox.widget.textbox
--   } end
-- end


local function get()

  local dw = wibox.widget {
      {
        --icon,
          {
            id = 'icon',
            image = "",
            resize = true,
            widget = wibox.widget.imagebox
          },
        id = "left",
        widget = wibox.container.place
      },
      {
        nil,
        {
          --temp,
          {
            id = 'temp',
            markup = 'Temp: <i></i>',
            font = beautiful.font,
            widget = wibox.widget.textbox
          },
          --wind,
          {
            id = 'wind',
            markup = 'Wind: ',
            font = beautiful.font,
            widget = wibox.widget.textbox
          },
          id = "data",
          layout = wibox.layout.fixed.vertical
        },
        nil,
        expand = 'none',
        id = 'right',
        layout = wibox.layout.align.vertical
      },
      spacing = dpi(3),
      layout = wibox.layout.ratio.horizontal
    }
    dw:ajust_ratio(2,.4,.6,0)

  local cmd = [[curl wttr.in/]]..location..[[?format="%C\n%t\n%w\n"]]
  awful.spawn.easy_async_with_shell ( 
    cmd,
    --'echo "Partly cloudy\n+70°F\n0mph\n"', --Hardcoded value so I can test this at work.
    function(stdout,stderr)
      -- Handles case when curl can't connect.
      -- if stderr:find('%a+') then
      --   return wibox.widget {
      --     markup = "OFFLINE",
      --     font = beautiful.font,
      --     widget = wibox.widget.textbox
      --   }
      -- end

      local lines = {}
      for s in stdout:gmatch("[^\r\n]+") do
        table.insert(lines,s)
      end

      -- for _,s in ipairs(lines) do
      --   naughty.notify { text = "Line: "..s }
      -- end

      local icon_file = lines[1]:gsub(" ","_"):lower()
      dw.left.icon.image = gfs.get_configuration_dir() .. 'widget/weather/icons/'..icon_file..'.svg'
      -- naughty.notify {text = "Icon's image: "..dw.left.icon.image}
      dw.right.data.temp.markup = "Temp: "..lines[2]
      dw.right.data.wind.markup = "Wind: "..lines[3]
      dw = wibox.widget {
        dw,
        widget = wibox.container.place
      }
    end
  )
  return dw
end

gears.timer {
  timeout = 887,
  call_now = true,
  autostart = true,
  callback = function()
    today = get()
  end
} : start()

return pi {
  widget = today,
  outer = false,
  margins = dpi(5),
}
