local wibox = require ('wibox')
local gears = require ('gears')
local fs = gears.filesystem
local slider = require ('util.panel_slider')
local st = require ('util.select_textbox')
local gen_toggle = require ('layout.settings.content_view.gen_toggle')
-- args
-- input = the audio device name
--
local gen_audio = function (device, is_input)
  local widget_to_display = {
    is_input and {
      slider {
        name = 'vol',
        getter = [[pamixer --sink ]]..device..[[ --get-volume]],
        setter = [[pamixer --sink ]]..device..[[ --set-volume]],
        -- label = [[VOL:]],
        label = [[]],
        widget = {
          toggle {
            cmd = 'pamixer -t',
            on_img = 'airplane.svg',
            off_img = 'airplane.svg',
          }
        },
        vertical = false,
        -- image = 'volume.svg'
      },
      margins = dpi(8),
      widget = wibox.container.margin
    },
    not is_input and {
      slider {
        name = 'mic',
        getter = [[pamixer --source ]]..device..[[ --get-volume]],
        setter = [[pamixer --source ]]..device..[[ --set-volume]],
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

  local box = {
    view = (is_input and 'input::' .. device) or 'output::' ..device,
    widget = widget_to_display
  }
  return box
end

return gen_display
