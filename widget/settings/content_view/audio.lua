local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('util.toggle')
local gen_toggle = require ('widget.settings.content_view.gen_toggle')
local st = require ('util.select_textbox')
local slider = require ('util.panel_slider')
local ib = require ('util.img_button')

local audio = wibox.widget {
  gen_toggle {
    textbox = st {
      empty_text = " N/A ",
      initial_cmd = [[pamixer --list-sinks | grep -v "Monitor of" | grep -v "Sinks" | cut -d '"' -f 4 | head -n1]],
      pop_cmd = [[pamixer --list-sinks | grep -v "Monitor of" | grep -v "Sinks" | cut -d '"' -f 4]],
      setter_post = [[]],
      setter_cmd = [[pamixer ]],
    },
    disable_toggle = true,
    text = 'Output Device',
    -- cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Send a notification'
  },
  -- gen_toggle {
  --   text = 'Mute?',
  --   cmd = 'notify-send test',
  --   margins = dpi(10),
  --   inactive_bg = beautiful.transparent,
  --   active_bg = beautiful.transparent,
  --   tooltip = 'Send a notification'
  -- },
  {
    slider {
      name = 'vol',
      getter = [[pamixer --get-volume]],
      setter = [[pamixer --set-volume]],
      -- label = [[VOL:]],
      label = [[]],
      vertical = false,
      -- image = 'volume.svg'
    },
    margins = dpi(8),
    widget = wibox.container.margin
  },
  gen_toggle {
    textbox = st {
      empty_text = " N/A ",
      initial_cmd = [[pamixer --list-sources | grep -v "Monitor of" | grep -v "Sources" | cut -d '"' -f 4 | head -n1]],
      pop_cmd = [[pamixer --list-sources | grep -v "Monitor of" | grep -v "Sources" | cut -d '"' -f 4]],
      setter_post = [[]],
      setter_cmd = [[]],
    },
    text = 'Input Device',
    disable_toggle = true,
    -- cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    -- tooltip = 'Send a notification'
  },
  {
    slider {
      name = 'mic',
      getter = [[pamixer --default-source --get-volume]],
      setter = [[pamixer --default-source --set-volume]],
      -- label = [[VOL:]],
      label = [[]],
      vertical = false,
      -- image = 'volume.svg'
    },
    margins = dpi(8),
    widget = wibox.container.margin
  },
  layout = wibox.layout.flex.vertical
}
audio.max_widget_size = dpi(50)

return audio


