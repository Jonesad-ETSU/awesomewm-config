local clickable = require ('widget.util.clickable')
-- local naughty = require ('naughty')
-- local pi        = require ('widget.util.panel_item')
local color   = require ('gears.color').recolor_image
local wibox     = require ('wibox')
local awful     = require ('awful')
local beautiful = require ('beautiful')
local gfs       = require ('gears.filesystem')

--[[
--  image function options = {
--      image,
--      bg => background color
--      cmd => command to run when clicking button
--      stdout_cmd => command to run from output of button
--      show_widget => widget to show on clickn
--      tooltip
--  }
--]]

local button = function (options)

  local function parse_image_path(path)
    if path[1] ~= '/' then
      return gfs.get_configuration_dir() .. 'icons/' .. path
      -- require('naughty').notify { text = l}
      -- return l
    else 
      -- require('naughty').notify { text = path}
      return path
    end
  end

    local image
    if not options.widget then
      local img
      local img_path
      if options.recolor then
        img = color(parse_image_path(options.image), beautiful.wibar_fg)
        -- img = color(options.image, beautiful.wibar_fg)
      else 
        img = options.image
      end


      image = wibox.widget {
        {
          image = img or options.image or gfs.get_configuration_dir() .. 'icons/unknown.svg',
          resize = true,
          widget = wibox.widget.imagebox
        },
        widget = wibox.container.place
      }
    else image = options.widget end

    if options.bg then
      image = wibox.widget {
        image,
        bg = options.bg,
        widget = wibox.container.background
      }
    end

    if not options.hide_tooltip then
        local tt = awful.tooltip {
            objects = { image },
	    --mode = 'outside',
	    delay_show = 1,
            text = options.tooltip or options.cmd
        }
    end

    image:connect_signal (
      'activate', function()
        if options.cmd then
          awful.spawn.easy_async_with_shell (
            options.cmd,
            function(stdout)
              if options.stdout_cmd then
                options.stdout_cmd(stdout)
              end
            end
          )
        elseif options.show_widget then
          local shown = require(options.show_widget)
          shown:emit_signal('toggle')
        end
      end
  )
    if options.buttons then
      return clickable(image, options.buttons)
    else return clickable(image) end
end

return button

