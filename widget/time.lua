local wibox = require ('wibox')
local beautiful = require ('beautiful')
local gears = require('gears')
local gfs = gears.filesystem
local dpi = beautiful.xresources.apply_dpi
local pi  = require ('util.panel_item')
local color = require('gears.color').recolor_image

-- require('naughty').notify {text = beautiful.font }

local calendar = pi {
  widget = wibox.widget {
    {
      {
        {
          image = color(gfs.get_configuration_dir() .. '/icons/calendar.svg',beautiful.wibar_fg),
          resize = true,
          widget = wibox.widget.imagebox
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      {
        format = "%a, %b %d",
        font = beautiful.small_font,
        align = 'center',
        widget = wibox.widget.textclock
      },
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.place
  },
  -- left = dpi(8),
  -- right = dpi(8),
  margins = dpi(4)
}

local time = pi {
  widget = wibox.widget {
    {
      {
        {
            image = color(gfs.get_configuration_dir() .. '/icons/clock.svg',beautiful.wibar_fg),
            resize = true,
            widget = wibox.widget.imagebox
        },
        margins = dpi(3),
        widget = wibox.container.margin
      },
      {
        format = "%I:%M %p",
        font = beautiful.small_font,
        align = 'center',
        widget = wibox.widget.textclock
      },
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.place
  },
  -- left = dpi(8),
  -- right = dpi(8),
  margins = dpi(6)
}


return wibox.widget
{
  -- {
    calendar,
    time,
    spacing = dpi(4),
    layout = wibox.layout.flex.horizontal
  -- },
  -- widget = wibox.container.place
}
