local beautiful = require ('beautiful')
local popup	= require ('widget.util.my_popup')
-- local awful 	= require ('awful')
local wibox 	= require ('wibox')
local gears 	= require ('gears')
local dpi 	= require ('beautiful.xresources').apply_dpi
--local pi	= require ('widget.util.panel_item')
local ib	= require ('widget.util.img_button')

local shutdown = ib {
  image = "shutdown.svg",
  recolor = true,
  tooltip = "Turn off the Computer",
  cmd = "systemctl poweroff"
}

local reboot = ib {
  image = "reboot.svg",
  recolor = true,
  tooltip = "Reboots the Computer",
  cmd = "systemctl reboot"
}

local sleep = ib {
  image = "sleep.svg",
  recolor = true,
  tooltip = "Save system state to RAM and enter low-power mode",
  cmd = "systemctl suspend"
}

local hibernate = ib {
  image = "hibernate.svg",
  recolor = true,
  tooltip = "Save system state to storage and poweroff",
  cmd = "systemctl hibernate"
}

local log_out = ib {
  image = "log_out.svg",
  recolor = true,
  tooltip = "End the Current User Session",
  cmd = "loginctl terminate-user $(whoami)"
}

local power_widget = wibox.widget {
  {
    {
      {
        markup = "Think Wisely, <i>" .. os.getenv('USER').."</i>!!",
        align = 'center',
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

local p = popup (
  power_widget,
  {
    width = dpi(800),
    height = dpi(200),
    shape = gears.shape.rounded_rect,
    border_width = 0,
    border_color = beautiful.wibar_bg,
    fullscreen = true
  })
p:emit_signal('toggle')

return p

