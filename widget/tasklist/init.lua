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
        --bg_focus = "#cccccc",
        fg_focus = "#cccccc",
        align = 'center',
        --shape_border_color = "#ebe321",
      },
      layout = {
        widget = wibox.container.place,
        layout = wibox.layout.flex.horizontal
      }
    },
    margins = dpi(2),
    outer = true,
    shape = gears.shape.rounded_bar,
    spacing = 20
  }
  return s.tasklist
end

return make_tasklist
