local wibox = require ('wibox')
local awful = require ('awful')
--local beautiful = require ('beautiful')
local pi = require ('widget.util.panel_item')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')

local make_tasklist = function (s)--(s)

  local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal(
          'request::activate', 'tasklist',
          { raise = true }
        )
      end
    end),
    awful.button({ }, 4, function()
      awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function()
      awful.client.focus.byidx(-1)
    end)
  )

  local layout_widget = pi {
            widget = wibox.widget {
              awful.widget.layoutbox(),
              widget = wibox.container.place
            },
            margins = dpi(4),
            -- name = "Layout",
            -- margins = dpi(5),
            -- ratio = {
            --     target  = 2,
            --     before  = 0.8,
            --     at      = 0.2,
            --     after   = 0
            -- }
    }
    layout_widget:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

  local tasklist = wibox.widget {
      {
          layout_widget,
          require ('widget.launchers'),
          expand = 'none',
          spacing = 3,
          layout = wibox.layout.fixed.horizontal
      },
      {
        {
          awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            widget_template = {
              {
                wibox.widget.base.make_widget(),
                forced_height = dpi(2),
                id            = 'background_role',
                widget        = wibox.container.background,
              },
              {
                {
                  id     = 'clienticon',
                  widget = awful.widget.clienticon,
                },
                margins = dpi(1),
                widget  = wibox.container.margin
              },
              nil,
              create_callback = function(self, c, index, objects) --luacheck: no unused args
                  self:get_children_by_id('clienticon')[1].client = c
              end,
              spacing = 0,
              layout = wibox.layout.align.vertical,
            },
            style = {
              shape = gears.shape.rounded_bar,
              --shape_border_width = dpi(1),
              shape_border_width = 0,
              bg_focus = "#ffffff",
              --disable_task_name = true,
              align = 'center',
              spacing = 5,
              --shape_border_color = "#ebe321",
            },
            layout = {
              widget = wibox.container.place,
              layout = wibox.layout.flex.horizontal
            }
          },
          --require ('widget.button.rofi_launcher'),
          layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.place
      },
      require ('widget.button.rofi_launcher'),
      spacing = 0,
      layout = wibox.layout.align.horizontal
    -- layout = wibox.layout.flex.horizontal
    }


  -- s.taglist = pi {
  --   widget = tasklist,
  --   --margins = dpi(2),
  --   margins = dpi(3),
  --   outer = true,
  --   shape = gears.shape.rounded_bar,
  --   spacing = 20
  -- }

  s.tasklist = pi {
    widget = tasklist,
    --margins = dpi(2),
    left = dpi(16),
    right = dpi(16),
    margins = dpi(3),
    outer = true,
    shape = gears.shape.rounded_bar,
    spacing = 20
  }

  --tasklist:ajust_ratio(2,.25,.7,.05)
  -- tasklist:ajust_ratio(2,.25,.7,.05)

  return s.tasklist
end

return make_tasklist
