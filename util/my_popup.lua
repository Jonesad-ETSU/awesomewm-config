local beautiful	= require ('beautiful')
local gears 	= require ('gears')
local wibox 	= require ('wibox')
local awful 	= require ('awful')
local leave_action = true

local popup = function (w, options)
  options = options or {}

  local popup_wibox = wibox {
    widget	= w,
    visible	= false,
    ontop	= true,
    splash 	= true,
    type	= options.type or 'normal',
    width 	= options.width or 1000,
    height 	= options.height or 500,
    shape	= options.shape or gears.shape.rounded_rect,
    border_width = options.border_width or 0,
    border_color = options.border_color or beautiful.wibar_fg,
    bg	= options.bg or beautiful.wibar_bg,
    fg	= options.fg or beautiful.wibar_fg
  }

  if options.fullscreen then
    local screen_geo = awful.screen.focused().geometry
    local screen_width, screen_height = screen_geo.width, screen_geo.height
    local background_wibox = wibox {
      widget = {},
      visible = popup_wibox.visible,
      ontop = popup_wibox.ontop,
      splash = popup_wibox.splash,
      type = popup_wibox.type,
      width = screen_width,
      height = screen_height,
      bg = "#00000055",
    }
    background_wibox:setup {
      wibox.widget.base.make_widget(),
      bg = beautiful.transparent,
      widget = wibox.container.background
    }
  end

  local placement = options.placement or awful.placement.centered
  --naughty.notify { text = "type: " .. type(placement)}
  local place = awful.placement
  if type(placement) == "string" then
    if placement == "centered" then
      place.centered(popup_wibox)
    elseif placement == "top" then
      place.top(popup_wibox)
    elseif placement == "top-right" then
      place.top_right(popup_wibox)
    elseif placement == "top-left" then
      place.top_left(popup_wibox)
    elseif placement == "bottom-left" then
      place.bottom_left(popup_wibox)
    elseif placement == "bottom-right" then
      place.bottom_right(popup_wibox)
    elseif placement == "bottom" then
      place.bottom(popup_wibox)
    elseif placement == "left" then
      place.left(popup_wibox)
    elseif placement == "right" then
      place.right(popup_wibox)
    end
  elseif type(placement) == "table" or type(placement) == "function" then
    placement(popup_wibox)
  else
    place.centered(popup_wibox)
  end

  local function toggle()
    popup_wibox.visible = not popup_wibox.visible
    if background_wibox then background_wibox.visible = popup_wibox.visible end
    if popup_wibox.visible then
      mouse.coords {
        x = (options.mouse and options.mouse.x) or (popup_wibox.x + popup_wibox.width/2),
        y = (options.mouse and options.mouse.y) or (popup_wibox.y + popup_wibox.height/2),
      }
    end
  end

  popup_wibox:connect_signal (
    'toggle',
    function()
      toggle()
    end
  )

  awesome.connect_signal (
    'toggle::mouse::leave',
    function(enable)
      leave_action = enable or false 
      -- leave_action = not leave_action 
    end
  )
  popup_wibox:connect_signal (
    'mouse::leave',
    function()
      if leave_action then
        toggle()
      -- else
      --   leave_action = true
      end
    end
  )

  return popup_wibox
end

return popup
