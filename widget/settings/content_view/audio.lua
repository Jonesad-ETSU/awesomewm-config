local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('widget.util.toggle')
local ib = require ('widget.util.img_button')

local function gen_toggle(args)
  local pane = wibox.widget {
    args.widget or {
      markup = args.text or "TEXT",
      font = beautiful.font,
      align = 'center',
      widget = wibox.widget.textbox 
    },
    nil,
    toggle {
      on_cmd = args.on_cmd,
      off_cmd = args.off_cmd,
      cmd = args.cmd,
      img = args.img,
      on_img = args.on_img,
      off_img = args.off_img,
      inactive_bg = args.inactive_bg,
      active_bg = args.active_bg,
      margins = args.margins or 0,
      buttons = args.buttons,
      tooltip = args.tooltip
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
  return pane
end
local audio = wibox.widget {
  gen_toggle {
    text = 'Volume',
    cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Send a notification'
  },
  gen_toggle {
    text = 'test2',
    cmd = 'notify-send test',
    margins = dpi(10),
    inactive_bg = beautiful.transparent,
    active_bg = beautiful.transparent,
    tooltip = 'Send a notification'
  },
  layout = wibox.layout.flex.vertical
}
audio.max_widget_size = dpi(50)

return audio


