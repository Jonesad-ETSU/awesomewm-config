local awful = require ('awful')
local gears = require ('gears')
local wibox = require ('wibox')
local naughty = require ('naughty')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local pi = require ('widget.util.panel_item')
local base_menu = awful.menu {}
local old_menu = nil
local base_entries = {}
local disable_mouse_leave = true

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
    -- base_menu = awful.menu {}
    awful.spawn.easy_async_with_shell (
       (args.pre_pop or '') .. (args.pop_cmd or '') .. (args.post_pop or ''),
      function(out)
        if old_menu then
          old_menu:hide()
          old_menu = nil
        else
          base_entries = {}
          local i = 1
          for line in out:gmatch("[^\r\n]+") do
            base_entries[i] = {
            -- base_menu:add ({ 
                line,
                function () 
                  awful.spawn.easy_async_with_shell((args.setter_cmd or '') .. ' ' .. line .. (args.setter_post or ''), function() end)
                  base_text.markup = line
                end,
                nil
              }
              i = i + 1
          end
          base_menu = awful.menu(base_entries)
          base_menu:toggle()
          old_menu = base_menu
        end
      end
    )
  end

  base_box:buttons (
    gears.table.join (
      awful.button( {}, 1, function()
        pop_menu()
        -- if disable_mouse_leave then
        awesome.emit_signal('toggle::mouse::leave')
        -- end
        -- disable_mouse_leave = not disable_mouse_leave
      end),
      awful.button( {}, 3, function()
        if old_menu then
          old_menu:hide()
          old_menu = nil
        end
      end)
    )
  )
  -- base_menu.keys = gears.table.join (
  --   awful.key( {}, "Escape", function()
  --     naughty.notify { text = 'ESCAPE KEY PRESSED' }
  --     if old_menu then
  --       -- old_menu:hide()
  --       old_menu = nil
  --     end
  --   end)
  -- )

  return base_box
end

return selectable_textbox
