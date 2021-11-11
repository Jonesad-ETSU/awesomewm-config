local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local color = gears.color.recolor_image

--[[
--      Documentation:
--      on_cmd => cmd to run when toggling on
--      off_cmd => cmd to run when toggling off
--      img => overrides both images
--      on_img => image override
--      off_img => image override
--      inactive_bg => 
--      active_bg => 
--      margins => 
--      buttons => 
--]]

local tbox = function (args)

  local function use_image(img,_color)
    return color(img, _color or beautiful.wibar_fg)
  end

  local toggle_img_dir = gears.filesystem.get_configuration_dir() .. '/icons/'
  local toggle = wibox.widget {
  {
    {
      id = 'image_container',
      image = use_image(toggle_img_dir.. (args.img or args.off_img or "toggle-off.svg")),
      resize = true,
      widget = wibox.widget.imagebox
    },
    margins = args.margins or 0,
    widget = wibox.container.margin
    },
    active = false,
    bg = args.inactive_bg or "#00000000",
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
  }

  if args.tooltip then
    awful.tooltip {
      objects = { toggle },
      delay_show = 1,
      text = args.tooltip
    }
  end

  toggle:buttons(gears.table.join (
    awful.button ( {}, 1, function()
      toggle.active = not toggle.active
      if toggle.active then
        toggle:get_children_by_id('image_container')[1].image = use_image(toggle_img_dir .. (args.img or args.on_img or 'toggle-on.svg'),args.active_fg)
	toggle.bg = args.active_bg or args.inactive_bg or "#00000000"
        if args.cmd or args.on_cmd then
          awful.spawn.easy_async_with_shell(
            args.cmd or args.on_cmd,
            function() end
          )
        end
      else
        toggle:get_children_by_id('image_container')[1].image = use_image(toggle_img_dir .. (args.img or args.off_img or 'toggle-off.svg'),args.inactive_fg)
	toggle.bg = args.inactive_bg or "#00000000"
        if args.cmd or args.off_cmd then
          awful.spawn.easy_async_with_shell(
            args.cmd or args.off_cmd,
            function() end
          )
        end
      end
    end)
  ))
  if args.buttons then
    local click = require('widget.util.clickable')
    return click(toggle,args.buttons)
  else 
    local hover = require ('widget.util.hover')
    return hover(toggle)
  end
end

return tbox
