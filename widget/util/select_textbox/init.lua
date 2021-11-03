local awful = require ('awful')
local gears = require ('gears')
local wibox = require ('wibox')
-- local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local pi = require ('widget.util.panel_item')

local selectable_textbox = function (args)
  local menus = {}
  local base_text = wibox.widget {
    markup = args.empty_text or "BASE_TEXT",
    font = beautiful.small_font,
    align = 'center',
    widget = wibox.widget.textbox
  }

  if args.initial_cmd then
    awful.spawn.easy_async_with_shell (
      args.initial_cmd,
      function(out)
        -- naughty.notify { text= 'cmd: '..args.initial_cmd.. 'init_out: '..out}
        base_text.markup = out 
      end
    )
  end

  local base_box = pi {
    widget = wibox.widget {
      base_text,
      widget = wibox.container.place
    },
    margins = dpi(3)
  }

  local function pop_menu ()
  -- Initializes a new menu since I can't figure out how to clear a menu
    base_menu = awful.menu {}
    awful.spawn.easy_async_with_shell (
       (args.pre_pop or '') .. (args.pop_cmd or '') .. (args.post_pop or ''),
      function(out)
        -- naughty.notify { text = out .. ' OUT'}
        for line in out:gmatch("[^\r\n]+") do
          base_menu:add ({ 
              line,
              function () 
                awful.spawn.easy_async_with_shell((args.setter_cmd or '') .. ' ' .. line .. (args.setter_post or ''))
                base_text.markup = line
              end
            })
        end
        base_menu:toggle()
      end
    )
    return base_menu
  end

  base_box:buttons(
    gears.table.join(
      awful.button( {}, 1, function()
        table.insert(menus,pop_menu())
      end),
      awful.button( {}, 2, function()
        for m in menus do
          -- naughty.notify { text = m .. ' menu_item' }
          m:hide()
        end
      end)
    )
  )
  return base_box
end

return selectable_textbox
