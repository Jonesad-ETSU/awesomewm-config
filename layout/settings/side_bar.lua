local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local hover = require ('widget.util.hover')
local beautiful = require ('beautiful')
local click = require ('widget.util.clickable')
local dpi = beautiful.xresources.apply_dpi
local alt_line = false

local function gen_side_panel(w)
  local pane = wibox.widget {
    {
      {
        w.label,
        nil,
        w.icon,
        expand = 'none',
        layout = wibox.layout.align.horizontal
      },

      left = dpi(15),
      right = dpi(15),
      margins = dpi(6),
      widget = wibox.container.margin
    },
    bg = (alt_line and beautiful.panel.bg) or beautiful.panel_item.bg,
    old_bg = (alt_line and beautiful.panel.bg) or beautiful.panel_item.bg,
    widget = wibox.container.background
  }
  alt_line = not alt_line
  return pane
end

local l = wibox.layout.flex.vertical()
l.max_widget_size = dpi(40)

local side_bar = require('widget.settings.side_bar')
for _,category in ipairs(side_bar) do
  local pane = gen_side_panel(category)
  pane = hover(pane) 
  pane:connect_signal(
    'mouse::enter',
    function(self)
      if not self.selected then
        self.bg = beautiful.mix(self.old_bg, beautiful.bg_select, 0.7)
      end
    end
  )

  pane:connect_signal(
    'mouse::leave',
    function(self)
      if not self.selected then
        self.bg = self.old_bg
      end
    end
  )

  pane:buttons ( gears.table.join (
    awful.button( {}, 1, function() 
      awesome.emit_signal('settings::content_view::show',category.view) 
      -- function()
        for _,child in ipairs(l:get_all_children()) do
          if child == pane then
            child.bg = beautiful.bg_select
            child.selected = true
          else
            child.bg = child.old_bg
            child.selected = false
          end
        end 
      -- end
    end)
  ))
  l:add(pane)
end

return l
