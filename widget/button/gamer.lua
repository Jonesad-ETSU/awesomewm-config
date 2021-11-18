local toggle = require ('util.toggle')
local pi = require ('util.panel_item')
local beautiful  = require ('beautiful')
local dpi  = beautiful.xresources.apply_dpi
local wibox = require ('wibox')

local gamer = toggle {
  img = 'game.svg',
  on_cmd = [[rfkill block $(rfkill | awk '// {if($2!="TYPE") print $2}') && notify-send 'Airplane Mode On']],
  off_cmd = [[rfkill unblock $(rfkill | awk '// {if($2!="TYPE") print $2}') && notify-send 'Airplane Mode Off']],
  -- active_bg = beautiful.wibar_fg,
  active_bg = beautiful.transparent,
  inactive_bg = beautiful.transparent,
  -- active_fg = beautiful.panel_item.bg,
  active_fg = beautiful.bg_select,
  inactive_fg = beautiful.wibar_fg, 
  tooltip = 'Toggles Gamemode.\nUses Feral\'s Gamemode',
  margins = dpi(10)
}

return pi {
  widget = wibox.widget { 
    gamer,
    widget = wibox.container.place
  },
  shape = beautiful.rounded_rect_shape,
  margins = 0,
  -- margins = dpi(12),
  -- bg = beautiful.transparent
  bg = beautiful.panel_item.bg,
}
