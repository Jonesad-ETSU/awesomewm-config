local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local darker = require ('widget.util.color').darker
local wibox = require ('wibox')
local dpi = beautiful.xresources.apply_dpi

--[[
--      getter => shell script to get value
--      setter => shell command to set value
--      tooltip => pass this with a string to have a tooltip
--      label => Left-side string to use
--      minimum => minimum possible value
--]]
local nb = function(args)
  local bar = wibox.widget {
    bar_color = darker(beautiful.wibar_bg,15),
    bar_active_color = darker(beautiful.wibar_fg,-5),
    bar_shape = gears.shape.rounded_bar,
    minimum = args.minimum or 0,
    -- handle_border_width = dpi(1),
    handle_border_color = darker(beautiful.wibar_fg,-5),
    handle_width = dpi(10),
    handle_color = beautiful.wibar_fg,
    handle_shape = gears.shape.rounded_bar,
    widget = wibox.widget.slider
  }

  local value_text = wibox.widget {
    markup = "",
    align = 'left',
    font = beautiful.font,
    widget = wibox.widget.textbox
  }

  local label = wibox.widget {
    markup = args.label or "TEST",
    align = 'right',
    font = beautiful.font,
    widget = wibox.widget.textbox
  }


  bar:connect_signal(
    'property::value',
    function()
      awful.spawn(args.setter.. ' ' ..bar.value..(args.setter_post or ''))
      awful.spawn.easy_async_with_shell(
        args.getter,
        function(out)
          value_text.markup = "<i>"..out.."</i>"
        end
      )
    end
  )

  if args.tooltip then
    awful.tooltip {
      objects = { bar },
      delay_show = 1,
      text = args.tooltip,
      font = beautiful.font,
    }
  end

  -- Start out by changing pamixer's volume so it doesn't mute on startup everytime
  awful.spawn.easy_async_with_shell(
    args.getter,
    function(out)
      bar.value = tonumber(out)
    end
  )

  -- Change this
  local final = wibox.widget {
    label,
    bar,
    value_text,
    spacing = dpi(3),
    layout = wibox.layout.ratio.horizontal
  }
  final:ajust_ratio(2,.2,.65,.15)

  local old_cursor, old_wibox
  final:connect_signal(
    'mouse::enter',
    function()
      local w = mouse.current_wibox
      if w then
        old_cursor,old_wibox = w.cursor, w
        w.cursor = 'hand1'
      end
    end
  )

  final:connect_signal(
    'mouse::leave',
    function()
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
      end
    end
  )

  -- final = wibox.widget {
  --   final,
  --   margins = dpi(2),
  --   widget = wibox.container.margin
  -- }

  return final
end
return nb
