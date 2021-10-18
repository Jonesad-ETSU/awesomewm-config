local wibox = require ('wibox')
local awful = require ('awful')
local beautiful = require ('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem
local pi    = require ('widget.util.panel_item')
local ib    = require ('widget.util.img_button')
local slider    = require ('widget.util.panel_slider')
local toggle    = require ('widget.util.toggle')
local playing = false

local song = "\t\t\tOffline"
-- local artist = ""

local function highlight_widget(args)
  return pi {
    widget = args.widget,
    margins = 0,
    bg = args.bg or "#00000000",
    shape = args.shape or gears.shape.rounded_rect,
    shape_border_width = 0
  }
end

local song_title = wibox.widget {
  markup = song,
  font = beautiful.medium_font,
  align = 'center',
  widget = wibox.widget.textbox
}

local back_pic = ib {
  image = gfs.get_configuration_dir()..'icons/prev.svg',
  recolor = true,
  hide_tooltip = true,
  buttons = gears.table.join (
    awful.button( { }, 1, function()
      awful.spawn('mpc prev')
    end)
  )
}

local progressbar = wibox.widget {
  value = 0,
  max_value = 100,
  bar_shape = gears.shape.rounded_bar,
  shape = gears.shape.rounded_bar,
  forced_height = dpi(10),
  background_color = beautiful.panel_item.button_bg,
  color = beautiful.wibar_fg,
  widget = wibox.widget.progressbar
}

local watch = gears.timer {
  timeout = 1,
  autostart = false,
  callback = function() 
    awful.spawn.easy_async_with_shell(
      [[ [ $(mpc | grep -c 'playing') -ge 1 ] && mpc | awk '{if(NR==2) print $4}' | tr -d '()%']],
      function(out)
        progressbar.value = tonumber(out)
      end
    )
  end
}

local scroll = wibox.widget {
  layout = wibox.container.scroll.horizontal,
  speed = 10,
  song_title
}
scroll:pause() --starts out static for Offline
scroll:set_fps(5)
scroll:set_expand(false)
scroll:set_extra_space(dpi(50))

local pause_pic = toggle {
  on_img = 'pause.svg',
  off_img = 'play.svg',
  hide_tooltip = true,
  margins = dpi(8),
  buttons = gears.table.join (
    awful.button( { }, 1, function(--[[self--]])
      if playing then
        awful.spawn('mpc pause')
        watch:stop()
        scroll:pause()
      else
        awful.spawn('mpc play')
        watch:start()
        scroll:continue()
      end
      playing = not playing 
    end)
  )
}

local forward_pic = ib {
  image = gfs.get_configuration_dir()..'icons/next.svg',
  recolor = true,
  buttons = gears.table.join(
    awful.button( { }, 1, function()
      awful.spawn('mpc next')
    end)
  )
}

local tt = awful.tooltip {
  objects = { forward_pic },
  shape = gears.shape.rounded_rect,
  delay_show = 1,
  text = "TEST",
}

local mpc_vol = slider {
  getter = "mpc vol | cut -d ':' -f 2 | tr -d '%'",
  setter = "mpc vol",
  -- vertical = true,
  label_forced_width = dpi(8),
  --label_forced_height = dpi(8),
  tooltip = "Sets MPC volume (seperate from system volume)",
  image = gfs.get_configuration_dir() .. '/icons/volume.svg'
}

local repeat_button = toggle {
  on_img = 'repeat.svg',
  off_img = 'repeat.svg',
  on_cmd = 'mpc single on',
  off_cmd = 'mpc single off',
  active_bg = beautiful.wibar_fg, 
  inactive_fg = beautiful.wibar_fg, 
  active_fg = beautiful.wibar_bg, 
  inactive_bg = beautiful.panel_item.button_bg, 
  margins = dpi(8),
}

local shuffle_button = toggle {
  on_img = 'shuffle.svg',
  off_img = 'shuffle.svg',    
  on_cmd = 'mpc random on',
  off_cmd = 'mpc random off',
  active_bg = beautiful.wibar_fg, 
  inactive_fg = beautiful.wibar_fg, 
  active_fg = beautiful.wibar_bg, 
  inactive_bg = beautiful.panel_item.button_bg, 
  margins = dpi(8),
}

--Tooltip updates to show the next song in playlist
tt:connect_signal(
  'property::visible',
  function()
    awful.spawn.easy_async_with_shell (
      [[mpc queued]],
      function(out)
        out:gsub('\n',"")
        tt.markup = out
      end
    )
  end
)

local main = wibox.widget {
  {
    id = 'base_layout',
    layout = wibox.layout.ratio.vertical,
    spacing = dpi(5),
    scroll,
    {
      {
        {
          repeat_button,
          highlight_widget { 
            widget = wibox.widget {
              back_pic,
              margins = dpi(5),
              widget = wibox.container.margin
            }, 
            shape = gears.shape.circle,
          },
          highlight_widget {
            widget = pause_pic,
            shape = gears.shape.circle
          },
          highlight_widget { 
            widget = wibox.widget {
              forward_pic,
              margins = dpi(5),
              widget = wibox.container.margin
            }, 
            shape = gears.shape.circle 
          },
          shuffle_button,
          spacing = 0,
          layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.place
      },
      right = dpi(0),
      left = dpi(0),
      widget = wibox.container.margin
    },
    {
      progressbar,
      mpc_vol,
      spacing = dpi(5),
      layout = wibox.layout.flex.vertical
    }
  },
  bottom = dpi(10),
  left = dpi(10),
  right = dpi(10),
  -- right = dpi(10),
  widget = wibox.container.margin
}

-- local scroll = main:get_children_by_id('scrollable_container')[1]
main.base_layout:ajust_ratio(2,.3,.4,.3)


local final_widget = wibox.widget {
  nil, main, nil,
  layout = wibox.layout.align.horizontal
}

final_widget = wibox.widget {
  final_widget,
  left = dpi(15),
  right = dpi(15),
  -- bottom = dpi(10),
  widget = wibox.container.margin
}

--[[
-- Utilizes mpc's --wait flag to immediately respond to changes in song; then reruns it and the thread hangs -
-- until it receives the update signal. More efficient, snappier, and better for battery life than polling.
--]]
local function update_song(first)

  -- local cmd = [[mpc current -f "TITLE[%title%]\nARTIST[%artist%]"]]
  -- local cmd = [[mpc current -f "[%title%]\n[%artist%]"]]
  local cmd = [[mpc current -f "[%title%] - [%artist%]"]]
  if not first then cmd = cmd .. [[ --wait]] end

  awful.spawn.with_line_callback (
    cmd,
    {
      stdout = function(line)
        song_title.markup = line
      end,
      output_done = function()
        update_song(false)
      end
  })
end
update_song(true)

return pi {
  widget = final_widget,
  margins = dpi(6),
  outer = true,
  name = nil
}
