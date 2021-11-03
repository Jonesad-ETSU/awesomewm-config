local wibox = require ('wibox')
local fs = require ('gears').filesystem
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('widget.util.toggle')
local ib = require ('widget.util.img_button')
local gen_toggle = require ('widget.settings.content_view.gen_toggle')
local st = require ('widget.util.select_textbox')

local display_l = wibox.layout.flex.vertical()
display_l.max_widget_size = dpi(50)
-- local display = wibox.widget {
display_l:add (
  gen_toggle {
    text = 'Change Wallpaper',
    cmd = 'nitrogen',
    img = 'wall.svg',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Opens nitrogen, the wallpaper setter.'
  },
  gen_toggle {
    text = 'Screen?',
    cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Choose which screen\'s settings to edit.'
  },
  gen_toggle {
    textbox = st {
      empty_text = " N/A ",
      initial_cmd = "xrandr -q | awk '/[[:alnum:]]+\\.[[:alnum:]]+\\*/ {print $1}'",
      pop_cmd = "xrandr -q | awk '/^[[:space:]]+[[:digit:]]+/ {print $1}' | head -n 11",
      setter_post = [[ ; ]]..fs.get_configuration_dir()..[[/scripts/calculate-dpi.sh && xrdb merge ~/.Xresources && awesome-client 'awesome.restart()']],
      setter_cmd = [[xrandr -s]]
    },
    disable_toggle = true,
    text = "Screen Resolution",
    tooltip = "Changes the Screen Resolution.\nCurrent Resolution is shown in the box"
  },
  gen_toggle {
    textbox = st {
      empty_text = " N/A ",
      initial_cmd = "xrandr -q | grep -Eo '[[:alnum:]]+\\.[[:alnum:]]+\\*' | tr -d '*+'",
      pop_cmd = fs.get_configuration_dir() .. [[/scripts/get_curr_rates.sh]],
      setter_cmd = [[xrandr -r]]
    },
    disable_toggle = true,
    text = "Refresh Rates",
    tooltip = "Changes the Refresh Rate.\nCurrent Refresh Rate is shown in the box"
  }
)
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


