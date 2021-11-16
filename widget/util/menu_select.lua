local awful = require ('awful')
local n = require ('naughty').notify
local wibox = require ('wibox')
local gears = require ('gears')
local beautiful = require ('beautiful')
local hover = require ('widget.util.hover')
local dpi = beautiful.xresources.apply_dpi

-- ARGS
-- alt_colors = whether to alternate colors
-- start_alt_color = whether to start on the alternate color.
-- layout = the layout for the menu
-- box_layout = the layout for each item
-- box_margins = table representing the margins for each items
-- signal = the signal used for updating the corresponding views.
-- max_widget_space = the maximum widget space for flex layouts
-- fill_widget = the widgets to use to fill the menu.
-- fill_cmd = the cmd to populate the menu
-- add_function = the function to call when adding to the layout
-- shape = shape of the menu container
-- pre_output = prefix to output to be given to the menu header (eg. adding "<b>" to bolden the output)
-- post_output = postfix to output to be given to the menu header (eg. adding "</b>" to end the bolden from the prefix)
   
local menu = function (args)

  local alt = args.start_alt_color or false
  local function box(opts)
    opts = opts or {}
    opts.box_margins = opts.box_margins or {}
    alt = not alt

    local w = wibox.widget {
      {
        {
          -- label,
          (opts.table and opts.table.label) or (opts.str and {
            markup = opts.str,
            font = beautiful.font,
            align = 'center',
            widget = wibox.widget.textbox
          }),
          nil,
          -- icon,
          (opts.table and opts.table.icon) or (opts.img and {
            image = gears.color.recolor_image(opts.img,beautiful.wibar_fg),
            resize = true,
            widget =  wibox.widget.imagebox
          }),
          expand = 'none',
          layout = opts.layout or args.box_layout or wibox.layout.fixed.horizontal,
        },
        left = opts.box_margins.left or args.box_margins.left or dpi(3),
        right = opts.box_margins.right or args.box_margins.right or dpi(3),
        top = opts.box_margins.top or args.box_margins.top or dpi(3),
        bottom = opts.box_margins.bottom or args.box_margins.bottom or dpi(3),
        widget = wibox.container.margin
      },
      bg = (args.alt_colors and alt and beautiful.panel.bg) or beautiful.panel_item.bg,
      old_bg = (args.alt_colors and alt and beautiful.panel.bg) or beautiful.panel_item.bg,
      widget = wibox.container.background
    }
    return w
  end

  local l = (args.layout and args.layout()) or wibox.layout.flex.horizontal()
  l:reset()
  l.max_widget_space = args.max_widget_space or dpi(40)

  local function pane_handler(p, v)
    p = hover(p)
    p:connect_signal (
      'mouse::enter',
      function(self)
        if not self.selected then
          self.bg = beautiful.mix(self.old_bg, beautiful.bg_select, 0.7)
        end
      end
    )

    p:connect_signal(
      'mouse::leave',
      function(self)
        if not self.selected then
          self.bg = self.old_bg
        end
      end
    )

    p:buttons ( gears.table.join (
      awful.button( {}, 1, function()
        awesome.emit_signal(args.signal or 'settings::content_view::show', v)
          for _,child in ipairs(l:get_all_children()) do
            if child == p then
              child.bg = beautiful.bg_select
              child.selected = true
            else
              child.bg = child.old_bg
              child.selected = false
            end
          end
      end)
    )) 

    if args.add_function then
      args.add_function(l,p)
    else l:add(p) end
  end

  if args.fill_cmd then
    awful.spawn.easy_async_with_shell (
      args.fill_cmd,
      function(out)
          for line in out:gmatch("[^\r\n]+") do
            pane_handler (
              box { str = line },
              line
            )
          end
      end
    )  
  elseif args.fill_table then
    for _,widget in ipairs(args.fill_table) do
      pane_handler ( 
        box { table = widget },
        widget.view
      )
    end
  end

  -- awesome.connect_signal(
  --   'settings::test',
  --   function(t)
  --     n { text = "TEST "..t }
  --   end
  -- )
 
  return wibox.widget {
    l,
    shape = args.shape or beautiful.rounded_rect_shape,
    widget = wibox.container.background
  }

end

return menu
