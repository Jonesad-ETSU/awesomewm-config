local wibox     = require ('wibox')
local gears     = require ('gears')
local naughty     = require ('naughty')
local color_manipulation     = require ('widget.util.color')
local lighten = color_manipulation.lighter
local darker = color_manipulation.darker
local beautiful = require ('beautiful')
local dpi       = require ('beautiful.xresources').apply_dpi
local old_bg

local nw = function(arg)

  local bg_container = wibox.widget {
    --widget = {},
    bg = arg.bg or beautiful.panel_item.bg or "#282828",
    shape = arg.shape or beautiful.panel_item.shape or gears.shape.rounded_rect,
    --shape_border_color = "#aaaaff",
    shape_border_color = arg.shape_border_color or beautiful.panel_item.border_color or  "#888888",
    shape_border_width = arg.shape_border_width or dpi(0),
    widget = wibox.container.background
  }

  local w = wibox.widget {
    {
      arg.widget,
      left = arg.left or arg.margins or dpi(10),
      right = arg.right or arg.margins or dpi(10),
      top = arg.top or arg.margins or dpi(10),
      bottom = arg.bottom or arg.margins or dpi(10),
      widget = wibox.container.margin
    },
    spacing = arg.spacing or dpi(2),
    layout = wibox.layout.ratio.vertical
    --layout = wibox.layout.stack
  }

  if arg.name then
    w:add(wibox.widget {
      {
        {
          markup = arg.name,
          font = beautiful.font,
          align = 'center',
          widget = wibox.widget.textbox
        },
        bg = lighten(beautiful.wibar_bg,30) or "#888888",
        shape = gears.shape.rounded_bar,
        shape_border_width = dpi(0),
        widget = wibox.container.background
      },
      top = dpi(0),
      bottom = dpi(5),
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin
  })
    if arg.ratio then
      w:ajust_ratio(arg.ratio.target, arg.ratio.before, arg.ratio.at, arg.ratio.after)
    else w:ajust_ratio(2,.85,.15,0) end
  else w:ajust_ratio(1,0,1,0) end

  bg_container.widget = w

  bg_container:connect_signal(
    'mouse::enter',
    function()
      if arg.outer then return end
      old_bg = bg_container.bg
      bg_container.bg = darker(beautiful.wibar_bg,30) or "#888888"
    end
  )
  bg_container:connect_signal(
    'mouse::leave',
    function()
      if arg.outer then return end
      bg_container.bg = old_bg
      old_bg = nil
    end
  )
    return bg_container
end

return nw
