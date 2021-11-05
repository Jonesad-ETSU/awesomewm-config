local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local wibox 	= require ('wibox')
-- local naughty 	= require ('naughty')
local awful 	= require ('awful')
local gears 	= require ('gears')
local gfs 	= gears.filesystem
local color     = gears.color
local pi	= require ('widget.util.panel_item')

-- local wind_speed = {}
local location = "37303"
local today

local function get()

  local dw = wibox.widget {
    {
      {
        {
          id = 'icon',
          image = "",
          resize = true,
          widget = wibox.widget.imagebox
        },
        widget = wibox.container.place
      },
      {
        {    -- nil,
          {
            id = 'temp',
            markup = 'Unable to connect to wttr.in',
            align = 'center',
            font = beautiful.small_font,
            widget = wibox.widget.textbox
          },
          {
            id = 'wind',
            markup = '',
            font = beautiful.small_font,
            widget = wibox.widget.textbox
          },
          layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place
      },
      spacing = dpi(3),
      -- layout = wibox.layout.ratio.horizontal
      layout = wibox.layout.flex.vertical
    },
    widget = wibox.container.place
  }
    -- dw:ajust_ratio(2,.4,.6,0)

  local cmd = [[curl wttr.in/]]..location..[[?format="%C\n%t\n%w"]]
  awful.spawn.easy_async_with_shell (
    cmd,
    -- 'echo "Partly cloudy\n+70°F\n0mph\n"', --Hardcoded value so I can test this at work.
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
      --   -- naughty.notify { text = "Line: "..s }
      -- end

      local icon_file = lines[1]:gsub(" ","_"):lower()
      dw:get_children_by_id('icon')[1].image = color.recolor_image(gfs.get_configuration_dir() .. '/icons/'..icon_file..'.svg',beautiful.wibar_fg)
      -- dw:get_children_by_id('temp')[1].markup = "Temp: "..lines[2] .. "\nWind: " ..lines[3]
      dw:get_children_by_id('temp')[1].markup = lines[2]
      dw:get_children_by_id('wind')[1].markup = lines[3]
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
  margins = dpi(3),
}
