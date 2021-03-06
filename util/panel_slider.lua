local awful = require ('awful')
local beautiful = require ('beautiful')
local darker = require ('util.color').darker
local recolor = require ('gears.color').recolor_image
local wibox = require ('wibox')
local gears = require('gears')
local dpi = beautiful.xresources.apply_dpi

--[[
--      getter => shell script to get value
--      setter => shell command to set value
--      tooltip => pass this with a string to have a tooltip
--      label => Left-side string to use
--      vertical => Uses vertical layout
--      minimum => minimum possible value
--]]
local nb = function(args)

  args = args or {}
  local bar = wibox.widget {
    bar_color = beautiful.wibar_bg,
    -- bar_active_color = darker(beautiful.wibar_fg,-5),
    bar_active_color = beautiful.success,
    bar_active_shape = beautiful.rounded_rect_shape or gears.shape.rounded_bar,
    bar_shape = beautiful.rounded_rect_shape or gears.shape.rounded_bar,
    minimum = args.minimum or 0,
    -- handle_border_width = dpi(1),
    handle_border_color = beautiful.success,
    handle_width = dpi(8),
    -- handle_width = 0,
    handle_color = beautiful.success,
    handle_shape = beautiful.rounded_rect_shape or gears.shape.rounded_bar,
    widget = wibox.widget.slider
  }

  -- local value_text = wibox.widget {
  --   markup = "",
  --   align = 'center',
  --   font = beautiful.tiny_font,
  --   widget = wibox.widget.textbox
  -- }

  local label
  if args.widget then
    label = args.widget
  elseif args.image then
    label = wibox.widget {
      {
        image = recolor(gears.filesystem.get_configuration_dir()..'/icons/'..args.image,beautiful.wibar_fg),
        resize = true,
        widget = wibox.widget.imagebox,
      },
      halign = 'right',
      widget = wibox.container.place
    }
  else
    label = wibox.widget {
      markup = args.label or "TEST",
      align = 'right',
      font = beautiful.small_font,
      widget = wibox.widget.textbox
    }
  end

  local function chval()
    awful.spawn(args.setter.. ' ' ..bar.value..(args.setter_post or ''))
    -- I don't use value_text. If you want to, uncomment one of the two ways below.
    -- value_text.markup = "<i>"..bar.value.."</i>"
    -- The below is more fool proof but can be really CPU intensive if you spasm mouse over the slider
    -- awful.spawn.easy_async_with_shell(
    --   args.getter,
    --   function(out)
    --     value_text.markup = "<i>"..out.."</i>"
    --   end
    -- )
    if args.name then
      awesome.emit_signal('bars::update',bar.value, args.name)
    end
  end

  bar:connect_signal(
    'property::value',
    function()
      chval()
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

  -- Start out by changing bar's value so it doesn't do to default on startup everytime
  awful.spawn.easy_async_with_shell(
    args.getter,
    function(out)
      bar.value = tonumber(out)
    end
  )

  local bar_container
  if args.vertical then
    bar_container = wibox.widget {
      {
        bar,
        direction = 'east',
        widget = wibox.container.rotate
      },
      widget = wibox.container.place
    }
    label.halign = 'center'
  else bar_container = bar end
  local final = wibox.widget {
    nil,
    {
      -- args.vertical and value_text or label,
      not args.hide_label and not args.vertical and label,
      bar_container,
      spacing = dpi(3),
      layout = function()
	if args.vertical then
          label.forced_width = args.label_forced_width or nil
          label.forced_height = args.label_forced_height or nil
          return wibox.layout.fixed.vertical()
	end
	return wibox.layout.fixed.horizontal()
      end
    },
    -- args.vertical and label or value_text,
    not args.hide_label and args.vertical and label,
    expand = 'inside',
    spacing = dpi(3),
    layout = function()
      if args.vertical then
        return wibox.layout.ratio.vertical()
      end
      return wibox.layout.ratio.horizontal()
    end
  }
  final:ajust_ratio(2,.88,.12,0)


  local old_cursor, old_wibox, old_bg
  final:connect_signal(
    'mouse::enter',
    function()
      local w = mouse.current_wibox
      if w then
        old_cursor,old_wibox,old_bg = w.cursor, w, bar.bar_color
        w.cursor = 'hand1'
	bar.bar_color = beautiful.panel_item.highlight
      end
    end
  )

  final:connect_signal (
    'mouse::leave',
    function()
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
	bar.bar_color = old_bg
      end
    end)

  awesome.connect_signal(
    'bars::update', function(val,n)
      if n and n ~= args.name then return end
      bar.value = val
  end)

  -- final = wibox.widget {
  --   final,
  --   margins = dpi(2),
  --   widget = wibox.container.margin
  -- }

  return final
end
return nb
