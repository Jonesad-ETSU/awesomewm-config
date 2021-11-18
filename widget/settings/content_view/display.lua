local wibox = require ('wibox')
local fs = require ('gears').filesystem
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('widget.util.toggle')
local ib = require ('widget.util.img_button')
local menu = require ('widget.util.menu_select')
local gen_toggle = require ('widget.settings.content_view.gen_toggle')
local st = require ('widget.util.select_textbox')

local display_l = wibox.layout.grid.vertical()
display_l.homogenous = true
display_l.forced_num_cols = 1
display_l.expand = 'none'
-- local view_stack = wibox.layout.stack()
-- display_l.max_widget_size = dpi(50)
-- local display = wibox.widget {
display_l:add (
  gen_toggle {
    text = 'Change Wallpaper',
    cmd = 'nitrogen',
    img = 'wall.svg',
    margins = dpi(5),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Opens nitrogen, the wallpaper setter.'
  },
  gen_toggle {
    text = 'Screen Layout',
    cmd = 'arandr',
    img = 'wall.svg',
    margins = dpi(5),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Opens arandr'
  })
  local next_avail,_ = display_l:get_next_empty()
  display_l:add_widget_at(
  {
    {
      {
        menu {
          alt_colors = true,
          start_alt_color = true,
          layout = wibox.layout.flex.horizontal,
          box_margins = {
            top = dpi(0),
            bottom = dpi(0),
            left = dpi(0),
            right = dpi(0),
          },
          -- fill_table = require ('widget.settings.side_bar'),
          fill_cmd = [[xrandr --listmonitors | awk '{if(NF>=4) print $4}']],
          signal = [[settings::content_view::displays::show]],
          max_widget_size = dpi(20),
          box_layout = wibox.layout.flex.horizontal,
          -- signal = [[settings::content_view::show]],
          shape = beautiful.rounded_rect_shape
        },
        forced_height = dpi(40),
        widget = wibox.container.constraint
      },
      {
        require ('widget.settings.content_view.gen_display'),
        margins = dpi(15),
        widget = wibox.container.margin
      },
      layout = wibox.layout.fixed.vertical
    },
    bg = beautiful.panel_item.bg,
    shape = beautiful.rounded_rect_shape,
    widget = wibox.container.background
  }, next_avail, 1, 4, 1)


local kids = display_l:get_all_children()
local alt = false
for _,child in ipairs(kids) do
  -- require ('naughty').notify {text='test'} 
  display_l:replace_widget (child, wibox.widget {
    -- {
      child,
      -- bg = (alt and beautiful.panel.bg) or beautiful.panel_item.bg,
      -- shape = beautiful.rounded_rect_shape,
      -- widget = wibox.container.background
    -- },
    -- left = dpi(8),
    -- right = dpi(8),
    margins = dpi(8),
    widget = wibox.container.margin
  })
  alt = not alt
end

-- display.max_widget_size = dpi(50)

return display_l


