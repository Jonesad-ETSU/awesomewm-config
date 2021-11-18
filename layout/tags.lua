local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local beautiful = require ('beautiful')
local darker = require ('util.color').darker
local pi = require ('util.panel_item')
local dpi = beautiful.xresources.apply_dpi

local tags = function (s,side)
  local tags_box = wibox {
    visible = true,
    screen = s,
    type = 'dock',
    ontop = true,
    width = dpi(60),
    height = dpi(15),
    border_width = beautiful.panel.border_width,
    border_color = beautiful.panel.border_color,
    splash = true,
    shape = beautiful.rounded_rect_shape,
    widget = {}
  }

  local tags_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
          if client.focus then
              client.focus:move_to_tag(t)
          end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
          if client.focus then
              client.focus:toggle_tag(t)
          end
      end),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )

  -- tags_box : setup {
  --   pi {
  --     widget = wibox.widget {
  --       {
  --         format = "%I:%M %p",
  --         font = beautiful.small_font,
  --         widget = wibox.widget.textclock
  --       },
  --       widget = wibox.container.place
  --     },
  --     shape = beautiful.rounded_rect_shape,
  --     margins = dpi(3),
  --     -- margins = 0,
  --   },
  --   layout = wibox.layout.flex.horizontal
  -- }

  tags_box : setup {
    pi {
      widget = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
          shape = beautiful.rounded_rect_shape,
          disable_icon = true,
          squares_sel = '',
          squares_sel_empty = '',
          squares_unsel = '',
          squares_unsel_empty = '',
          bg_urgent = beautiful.bg_urgent,
          bg_occupied = beautiful.panel.fg,
          bg_focus = beautiful.success,
        },
        layout = {
          spacing = dpi(5),
          layout = wibox.layout.flex.horizontal
        },
        widget_template = {
          id = 'background_role',
          widget = wibox.container.background
        },
        buttons = tags_buttons
      },
      shape = beautiful.rounded_rect_shape,
      margins = dpi(3),
      -- margins = 0,
    },
    layout = wibox.layout.flex.horizontal
  }

  if side ~= 'top' then 
    awful.placement.bottom_left(tags_box)
  end

  return tags_box
end

return tags
