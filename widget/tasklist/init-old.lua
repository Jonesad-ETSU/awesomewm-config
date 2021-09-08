local wibox = require ('wibox')
local awful = require ('awful')
local beautiful = require ('beautiful')
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

	s.tasklist = pi {
          widget = awful.widget.tasklist {
          screen = s,
          filter = awful.widget.tasklist.filter.currenttags,
          buttons = tasklist_buttons,
          style = {
            shape = gears.shape.rounded_bar,
            shape_border_width = dpi(1),
            bg_focus = "#cccccc",
            fg_focus = "#cccccc",
            align = 'center',
            --shape_border_color = "#ebe321",
          },
          layout = {
            {
              spacing_widget = {
                forced_width = dpi(2),
                forced_height = dpi(2),
                thickness = 1,
                color = "#383838",
                widget = wibox.widget.separator
              },
              valign = 'center',
              align = 'center',
              widget = wibox.container.place
            },
            spacing = 1,
            layout = wibox.layout.flex.horizontal
          },
          widget_template = {
            {
              wibox.widget.base.make_widget(),
              forced_height = dpi(2),
              id = 'background_role',
              widget = wibox.container.background,
            },
            {
              {
                {
                        id = 'clienticon',
                        widget = awful.widget.clienticon,
                },
                margins = dpi(1),
                widget = wibox.container.margin
              },
              {
                id = 'text_role',
                widget = wibox.widget.textbox
              },
              layout = wibox.layout.fixed.horizontal
            },
            nil,
            create_callback = function(self, c, index, objects)
                    self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical
          }
      },
    margins = dpi(2),
    outer = true,
    spacing = -20
  }
    return s.tasklist
end

return make_tasklist
