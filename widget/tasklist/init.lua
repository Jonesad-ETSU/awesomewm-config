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

  local tasklist = wibox.widget {
    {
      awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        widget_template = {
            {
              wibox.widget.base.make_widget(),
              forced_height = 5,
              id            = 'background_role',
              widget        = wibox.container.background,
            },
            {
              {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
              },
              margins = 5,
              widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
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
      widget = wibox.container.place
    },
    require ('widget.button.rofi_launcher'),
    spacing = 0,
    layout = wibox.layout.ratio.horizontal
  }

  s.tasklist = pi {
    widget = tasklist,
    --margins = dpi(2),
    margins = dpi(3),
    outer = true,
    shape = gears.shape.rounded_bar,
    spacing = 20
  }

  tasklist:ajust_ratio(2,.95,.05,0)

  return s.tasklist
end

return make_tasklist
