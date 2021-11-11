local wibox = require ('wibox')
local gears = require ('gears')
local fs = gears.filesystem
local st = require ('widget.util.select_textbox')
local gen_toggle = require ('layout.settings.content_view.gen_toggle')
-- args
-- view = view name to be connected to
-- signal = name of signal to connect to
-- output = the display name
--
local gen_display = function (args)
  local box = {
    view = args.output,
    widget = {
      gen_toggle {
        textbox = st {
          empty_text = " N/A ",
          initial_cmd = "xrandr | awk /"..args.output.."/ {print $4} | cut -d '+' -f 1",
          pop_cmd = "xrandr | sed -n '/"..args.output.."/,/connected/{//!p;} | awk '{print $1} | 'head -n 15",
          setter_post = [[ ; ]]..fs.get_configuration_dir()..[[/scripts/calculate-dpi.sh && xrdb merge ~/.Xresources && awesome-client 'awesome.restart()']],
          setter_cmd = [[xrandr --output ]]..args.output..[[ --mode]]
        },
        disable_toggle = true,
        text = "Screen Resolution",
        tooltip = "Changes the Screen Resolution.\nCurrent Resolution is shown in the box"
      },
      gen_toggle {
        textbox = st {
          empty_text = " N/A ",
          initial_cmd = "xrandr | sed -n '/'"..args.output.."/,/connected/{//!p;}' | grep -Eo '[[:alnum:]]+\\.[[:alnum:]]+\\*' | tr -d '*+'",
          pop_cmd = fs.get_configuration_dir() .. [[/scripts/get_curr_rates.sh ]] .. args.output ,
          setter_cmd = [[xrandr --output ]]..args.output..[[ -r]]
        },
        disable_toggle = true,
        text = "Refresh Rates",
        tooltip = "Changes the Refresh Rate.\nCurrent Refresh Rate is shown in the box"
      },
    layout = wibox.layout.flex.vertical
    },
  } 
  return box
end

return gen_display
