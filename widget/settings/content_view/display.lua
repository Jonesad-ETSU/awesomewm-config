local wibox = require ('wibox')
local fs = require ('gears').filesystem
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('widget.util.toggle')
local ib = require ('widget.util.img_button')
local menu = require ('widget.util.menu_select')
local gen_toggle = require ('widget.settings.content_view.gen_toggle')
local st = require ('widget.util.select_textbox')

local display_l = wibox.layout.flex.vertical()
-- local view_stack = wibox.layout.stack()
display_l.max_widget_size = dpi(50)
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
  },
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
  require ('widget.settings.content_view.gen_display'),
  gen_toggle {
    textbox = st {
      empty_text = " N/A ",
      initial_cmd = "xrandr | awk '/eDP-1/ {print $4}' | cut -d '+' -f 1",
      pop_cmd = "xrandr | sed -n '/eDP-1/,/connected/{//!p;}' | awk '{print $1}' | head -n 12",
      setter_post = [[ ; ]]..fs.get_configuration_dir()..[[/scripts/calculate-dpi.sh && xrdb merge ~/.Xresources && awesome-client 'awesome.restart()']],
      setter_cmd = [[xrandr --output eDP-1 --mode]]
    },
    disable_toggle = true,
    -- cmd = 'notify-send test',
    text = "Screen Resolution",
    tooltip = "Changes the Screen Resolution.\nCurrent Resolution is shown in the box"
  }  -- view_stack
  -- menu {
  --   -- alt_colors = true,
  --   alt_colors = false,
  --   start_alt_color = true,
  --   layout = wibox.layout.flex.vertical,
  --   box_margins = {
  --     top = dpi(0),
  --     bottom = dpi(0),
  --     left = dpi(0),
  --     right = dpi(0),
  --   },
  --   -- fill_table = require ('widget.settings.side_bar'),
  --   fill_cmd = [[echo -e '1\n2']],
  --   signal = [[settings::test]],
  --   max_widget_size = dpi(20),
  --   box_layout = wibox.layout.flex.horizontal,
  --   -- signal = [[settings::content_view::show]],
  --   shape = beautiful.rounded_rect_shape
  -- }
  -- gen_toggle {
  --   textbox = st {
  --     empty_text = " N/A ",
  --     initial_cmd = "xrandr --listmonitors | awk '{if(NF>=4) print $4}' | head -n1",
  --     pop_cmd = "xrandr --listmonitors | awk '{if(NF>=4) print $4}'",
  --   },
  --   disable_toggle = true,
  --   text = "Screen",
  --   tooltip = "Chooses which Screen the below settings will affect."
  -- },
  -- -- gen_toggle {
  -- --   text = 'Make Primary?',
  -- --   cmd = 'notify-send test',
  -- --   margins = dpi(5),
  -- --   inactive_bg = beautiful.transparent,
  -- --   active_bg = beautiful.transparent,
  -- --   tooltip = 'Choose if the screen is primary.'
  -- -- },
  -- gen_toggle {
  --   textbox = st {
  --     empty_text = " N/A ",
  --     initial_cmd = "xrandr -q | awk '/[[:alnum:]]+\\.[[:alnum:]]+\\*/ {print $1}'",
  --     pop_cmd = "xrandr -q | awk '/^[[:space:]]+[[:digit:]]+/ {print $1}' | head -n 11",
  --     setter_post = [[ ; ]]..fs.get_configuration_dir()..[[/scripts/calculate-dpi.sh && xrdb merge ~/.Xresources && awesome-client 'awesome.restart()']],
  --     setter_cmd = [[xrandr -s]]
  --   },
  --   disable_toggle = true,
  --   text = "Screen Resolution",
  --   tooltip = "Changes the Screen Resolution.\nCurrent Resolution is shown in the box"
  -- },
  -- gen_toggle {
  --   textbox = st {
  --     empty_text = " N/A ",
  --     initial_cmd = "xrandr -q | grep -Eo '[[:alnum:]]+\\.[[:alnum:]]+\\*' | tr -d '*+'",
  --     pop_cmd = fs.get_configuration_dir() .. [[/scripts/get_curr_rates.sh]],
  --     setter_cmd = [[xrandr -r]]
  --   },
  --   disable_toggle = true,
  --   text = "Refresh Rates",
  --   tooltip = "Changes the Refresh Rate.\nCurrent Refresh Rate is shown in the box"
  -- }
)

-- local display_generator = require ('widget.settings.content_view.gen_display')
-- awful.spawn.easy_async_with_shell (
--   [[xrandr --listmonitors | awk '{if(NF>=4) print $4}']],
--   function(out) 
--     for l in out:gmatch('[^\r\n]+') do
--       view_stack:add(display_generator { output = l })
--     end
--   end
-- )
-- for _,view in ipairs(view_stack) do
--   awesome.connect_signal('settings::content_view::displays::show',function(v)
--     view.visible =  
--   end)
-- end


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


