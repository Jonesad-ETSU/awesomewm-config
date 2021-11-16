local wibox = require ('wibox')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local toggle = require ('widget.util.toggle')
-- local ib = require ('widget.util.img_button')
-- local textbox = require ('widget.util.select_textbox')

local generated_toggle = function (args)
  local pane = wibox.widget {
    {
      markup = args.text or "TEXT",
      font = beautiful.font,
      align = 'center',
      widget = wibox.widget.textbox 
    },
    nil,
    {
      (not args.disable_toggle and toggle {
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
      }),
      args.textbox or nil,
      spacing = dpi(5),
      layout = wibox.layout.fixed.horizontal
    },
    expand = 'none',
    layout = wibox.layout.align.horizontal
  }
  return pane
end
return generated_toggle
