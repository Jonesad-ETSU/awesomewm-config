local menu = require ('widget.util.menu_select')
local wibox = require ('wibox')
local awful = require ('awful')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
return menu {
  alt_colors = true,
  start_alt_colors = true,
  layout = wibox.layout.flex.vertical,
  box_layout = wibox.layout.align.horizontal,
  box_margins = {
    top = dpi(3),
    bottom = dpi(3),
    right = dpi(10),
    left = dpi(10)
  },
  max_widget_space = dpi(20),
  signal = 'settings::content_view::show',
  -- fill_cmd = [[]],
  fill_table = require ('widget.settings.side_bar'),
  -- fill_cmd = [[xrandr --listmonitors | awk '{if(NF>=4)print $4}']],
  shape = beautiful.rounded_rect_shape,
  -- add_function = wibox.layout.flex.vertical.add(),
  -- pre_output_unselected = '',
  -- pre_output_selected = '',
  -- post_output_unselected = '',
  -- post_output_selected = '',
}
