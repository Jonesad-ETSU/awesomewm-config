local beautiful = require ('beautiful')
local popup	= require ('widget.util.my_popup')
-- local awful 	= require ('awful')
local wibox 	= require ('wibox')
local gears 	= require ('gears')
local dpi 	= require ('beautiful.xresources').apply_dpi
--local pi	= require ('widget.util.panel_item')
local ib	= require ('widget.util.img_button')

local image_dir = gears.filesystem.get_configuration_dir() .. "/widget/power_popup/"

local shutdown = ib ({
  image = image_dir.."shutdown.svg",
  tooltip = "Turn off the Computer",
  cmd = "systemctl poweroff"
})

local reboot = ib ({
  image = image_dir.."reboot.svg",
  tooltip = "Reboots the Computer",
  cmd = "systemctl reboot"
})

local sleep = ib ({
  image = image_dir.."sleep.svg",
  tooltip = "Save system state to RAM and enter low-power mode",
  cmd = "systemctl suspend"
})

local hibernate = ib ({
  image = image_dir.."hibernate.svg",
  tooltip = "Save system state to storage and poweroff",
  cmd = "systemctl hibernate"
})

local log_out = ib ({
  image = image_dir.."log_out.svg",
  tooltip = "End the Current User Session",
  cmd = "loginctl terminate-user $(whoami)"
})

local power_widget = wibox.widget {
  {
    {
      {
        markup = "Think Wisely, <i>" .. os.getenv('USER').."</i>!!",
        font = beautiful.font .. " 32",
        widget = wibox.widget.textbox
      },
      {
        sleep,
        log_out,
        hibernate,
        reboot,
        shutdown,
        layout = wibox.layout.flex.horizontal,
      },
      layout = wibox.layout.flex.vertical
    },
    widget = wibox.container.place
  },
  margins = dpi(10),
  widget = wibox.container.margin
}
 
local p = popup(
  power_widget,
  {
    width = dpi(800),
    height = dpi(200),
    shape = gears.shape.rounded_rect,
    border_width = 0,
    border_color = beautiful.wibar_bg,
  })
p:emit_signal('toggle')

return p

