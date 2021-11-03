local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local naughty = require ('naughty')
local popup = require ('widget.util.my_popup')
local darker = require ('widget.util.color').darker
local toggle = require ('widget.util.toggle')
local ib = require ('widget.util.img_button')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local do_not_disturb = false


local notif = wibox.widget {
  {
    nil,
    {
      {
        markup = "<b>Notification Center</b>",
        font = beautiful.font .. ' 12',
        align = 'left',
        widget = wibox.widget.textbox
      },
      ib {
        widget = wibox.widget {
          {
            {
              markup = "<i>Clear All</i>",
              font = beautiful.font .. ' 10',
              align = 'center',
              widget = wibox.widget.textbox
            },
            margins = dpi(5),
            widget = wibox.container.margin
          },
          bg = darker(beautiful.wibar_bg,25),
          shape = gears.shape.rounded_rect,
          widget = wibox.container.background
        },
        tooltip = "Remove Current Notications",
        buttons = gears.table.join (
          awful.button ( {}, 1, function()
            naughty.destroy_all_notifications()
          end)
        )
      },
      layout = wibox.layout.fixed.vertical
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.horizontal
  },
  {
    base_layout = wibox.widget {
      spacing = dpi(5),
      max_widget_size = dpi(75),
      -- layout = wibox.layout.flex.vertical
      expand = true,
      forced_num_cols = 1,
      forced_num_rows = 5,
      layout = wibox.layout.grid
    },
    widget_template = {
      {
        {
          naughty.widget.icon,
          {
            naughty.widget.title,
            naughty.widget.message,
            {
              layout = wibox.layout.flex.vertical,
              widget = naughty.list.widgets,
            },
            layout = wibox.layout.flex.vertical
          },
          spacing = dpi(5),
          fill_space = true,
          layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(8),
        widget = wibox.container.margin
      },
      shape = gears.shape.rounded_rect,
      bg = darker(beautiful.panel_item.bg,15),
      widget = wibox.container.background
    },
    widget = naughty.list.notifications
  },
  {
    nil,
    toggle {
      img = 'discord.svg',
      inactive_bg = '#ff0000',
      active_bg = '#00ff00',
      margins = dpi(8),
      buttons = gears.table.join (
        awful.button({},1,function()
          awful.spawn('echo toggling > ~/dnd')
        end)
      )
    },
    nil,
    exand = 'none',
    layout = wibox.layout.align.horizontal
  },
  -- {
    -- {
      --
    --   markup = "<i>Do Not Disturb</i>",
    --   font = beautiful.font,
    --   align = 'center',
    --   widget = wibox.widget.textbox
    -- },
    -- widget = wibox.container.place
  -- },
  spacing = dpi(8),
  layout = wibox.layout.ratio.vertical
}
notif:ajust_ratio(2,.1,.8,.1)

local p = popup (
  wibox.widget {
    {
      {
        notif,
        margins = dpi(10),
        widget = wibox.container.margin
      },
      bg = darker(beautiful.wibar_bg,5),
      shape = gears.shape.rounded_rect,
      widget = wibox.container.background
    },
    margins = dpi(16),
    widget = wibox.container.margin
  },
  {
    width = dpi(350),
    height = dpi(500),
    border_width = dpi(2),
    border_color = darker(beautiful.wibar_bg,30),
    placement = "bottom-right",
    -- placement = "bottom",
  }
)

naughty.connect_signal(
  'request::do_not_disturb',
  function()
    do_not_disturb = not do_not_disturb
    naughty.destroy_all_notifications(nil, 1)
  end
)

naughty.connect_signal(
  'request::display',
  function()
    if not do_not_disturb then
      p:emit_signal('toggle')
    end
  end
)

return p
