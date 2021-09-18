local wibox = require ('wibox')
local naughty = require ('naughty')
local awful = require ('awful')
local beautiful = require ('beautiful')
local dpi = require ('beautiful.xresources').apply_dpi
local gears = require ('gears')
local gfs = gears.filesystem
local color = gears.color.recolor_image
local pi    = require ('widget.util.panel_item')
local click    = require ('widget.util.clickable')
local playing = false

local song = "Song"
local artist = "Artist"

local function highlight_widget(w)
  return pi {
    widget = w,
    margins = 2,
    shape = gears.shape.rounded_bar,
    shape_border_width = 0
  }
end

local album_art = wibox.widget {
  image = gears.filesystem.get_configuration_dir() .. '/widget/music/album.png',
  resize = true,
  widget = wibox.widget.imagebox
}

local song_title = wibox.widget {
  markup = "<span font='"..beautiful.font.." 10'><b>"..song.."</b></span>",
  font = beautiful.font,
  align = 'center',
  widget = wibox.widget.textbox
}

local artist_title = wibox.widget {
  markup = "<span font='"..beautiful.font.." 8'><i>"..artist.."</i></span>",
  font = beautiful.font,
  align = 'center',
  widget = wibox.widget.textbox
}

local back_pic = click (
  wibox.widget {
    image = color(gfs.get_configuration_dir()..'widget/music/prev.svg',"#ffffff"),
    resize = true,
    widget = wibox.widget.imagebox
  },
  gears.table.join(
    awful.button( { }, 1, function() 
      awful.spawn('mpc prev')
    end)
  )
)

local pause_pic = click (
  wibox.widget {
    -- markup = "<b>TOGGLE</b>",
    -- align = 'center',
    -- font = beautiful.font,
    -- widget = wibox.widget.textbox
    image = color(gfs.get_configuration_dir()..'widget/music/toggle.svg',"#ffffff"),
    resize = true,
    widget = wibox.widget.imagebox
  },
  gears.table.join (
    awful.button( { }, 1, function(--[[self--]])
      awful.spawn('mpc toggle')
--[[      if playing then
        self.markup = "<b>PLAY</b>"
      else
        self.markup = "<b>PAUSE</b>"
      end --]]
      playing = not playing
    end)
  )
)

local forward_pic = click (
  wibox.widget {
    -- markup = "<b>NEXT</b>",
    -- align = 'center',
    -- font = beautiful.font,
    -- widget = wibox.widget.textbox
    image = color(gfs.get_configuration_dir()..'widget/music/next.svg',"#ffffff"),
    resize = true,
    widget = wibox.widget.imagebox
  },
  gears.table.join(
    awful.button( { }, 1, function()
      awful.spawn('mpc next')
    end)
  )
)

local tt = awful.tooltip {
  objects = { forward_pic },
  shape = gears.shape.rounded_bar,
  delay_show = 1,
  text = "TEST"
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

-- local progressbar = wibox.widget {
--   value = 33,
--   max_value = 100,
--   bar_shape = gears.shape.rounded_bar,
--   shape = gears.shape.rounded_bar,
--   bar_border_color = "#ff00ff",
--   bar_border_width = 1,
--   border_width = 2,
--   border_color = "#00ffff",
--   forced_height = dpi(10),
--   color = "#00ff00",
--   widget = wibox.widget.progressbar
-- }
--
-- progressbar = click(progressbar,
--   gears.table.join(
--     awful.button( {}, 1, function()
--       awful.spawn('mpc toggle')
--     end),
--     awful.button( {}, 3, function()
--       awful.spawn('alacritty -e ncmpcpp')
--     end)
--   )
--)

-- local bar_widget = wibox.widget {
--   back_pic,
--   progressbar,
--   forward_pic,
--   spacing = dpi(10),
--   expand = 'inner',
--   layout = wibox.layout.align.horizontal
-- }

local main = wibox.widget {

  id = 'bg_container',
  layout = wibox.layout.flex.vertical,
  spacing = dpi(10),
  --expand = 'none',
  {
    nil,
    highlight_widget(wibox.widget {
      song_title,
      artist_title,
      layout = wibox.layout.fixed.vertical
    }),
    nil,
    layout = wibox.layout.align.horizontal
  },
  {
    {
      highlight_widget(back_pic),
      highlight_widget(pause_pic),
      highlight_widget(forward_pic),
      spacing = 5,
      layout = wibox.layout.flex.horizontal
    },
    right = dpi(10),
    left = dpi(10),
    widget = wibox.container.margin
    --widget = wibox.container.background
  },
  --[[{
    layout = wibox.layout.fixed.horizontal,
    highlight_widget (
      wibox.widget {
        markup = "TIME",
        font = beautiful.font,
        align = 'center',
        widget = wibox.widget.textbox
      }
    ),
    highlight_widget(progressbar),
  }--]]
}

--main.bg_container:ajust_ratio(2, .7, .1, .2)

local final_widget = wibox.widget {
  {
    album_art,
    shape = gears.shape.rounded_rect,
    shape_border_width = dpi(2),
    --shape_border_width = 0,
    shape_border_color = "#00cccc",
    shape_clip = true,
    widget = wibox.container.background
  },
  {
    main,
    left = dpi(15),
    right = dpi(15),
    widget = wibox.container.margin
  },
  nil,
  spacing = dpi(3),
  layout = wibox.layout.align.horizontal
}

--[[
-- Utilizes mpc's --wait flag to immediately respond to changes in song; then reruns it and the thread hangs -
-- until it receives the update signal. More efficient, snappier, and better for battery life than polling.
--]]
local function update_song(first)

  local cmd = [[mpc current -f "TITLE[%title%]\nARTIST[%artist%]"]]
  if not first then cmd = cmd .. [[ --wait]] end

  awful.spawn.with_line_callback (
    cmd,
    {
      stdout = function(line)
        if line:find("TITLE") then
          song_title.markup = "<span font= '"..beautiful.font.." 10'><b><i>"..
            line:gsub("TITLE","").."</i></b></span>"
        else
          artist_title.markup = "<span font= '"..beautiful.font.." 8'><i>"..
            line:gsub("ARTIST","").."</i></span>"
        end
      end,
      output_done = function()
        update_song(false)
      end
  })
end
update_song(true)

return pi {
  widget = final_widget,
  margins = dpi(10),
  outer = true,
  name = nil
}
