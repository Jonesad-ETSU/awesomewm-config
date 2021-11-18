pcall (require, "luarocks.loader")

local wibox     = require ('wibox')
local pi        = require ('util.panel_item')
local clickable = require ('util.clickable')
local beautiful = require ('beautiful')
local awful     = require ('awful')
local gears     = require ('gears')
local dpi       = require ('beautiful.xresources').apply_dpi
-- local bling     = require ('bling')
local naughty   = require ('naughty')

local power = function()
  local bat_pct = -1
  local l = wibox.layout.flex.horizontal()

  l.fill_space = true

  local function make_heart_widget (fullness, charging)
    local images_dir = gears.filesystem.get_configuration_dir() .. '/icons/'
    local colors = {
      discharging = beautiful.bg_urgent,
      charging = beautiful.success,
    }
    local color
    if not charging then --bat_state == 'discharging' or bat_state == 'Discharging' then
      color = colors.discharging
    else color = colors.charging end

    return wibox.widget {
      image = gears.color.recolor_image(images_dir .. "heart-" .. fullness .. ".svg", color),
      resize = true,
      widget = wibox.widget.imagebox
    }
  end

  -- Generate all possible heart possibilities
  local hearts = {
    charging = {
      full  = make_heart_widget('full', true),
      half  = make_heart_widget('half', true),
    },
    not_charging = {
      full  = make_heart_widget('full', false),
      half  = make_heart_widget('half', false),
    },
    empty = make_heart_widget('empty', false) -- doesn't matter since its an empty svg
  } 

  local function get_hearts_widget (pct_remaining, status)

        if tonumber(pct_remaining) < 100 then
          pct_remaining = pct_remaining + 10 --makes 90-99 still a full heart for instance
        end

      local num_hearts = 5
      local batl = wibox.layout.flex.horizontal()
      batl:fill_space (true)
      batl.spacing = dpi(5)

      local wholes = math.floor (pct_remaining / (100/num_hearts))

      local charging = status:lower() ~= 'discharging'
      if charging then
        for _ = 1, wholes do
          batl:add(hearts.charging.full)
        end
      else for _ = 1, wholes do
          batl:add(hearts.not_charging.full)
        end end
      pct_remaining = pct_remaining - ( wholes * 100/num_hearts )

      if pct_remaining == 0 then
        return wibox.widget {
          batl,
          top = dpi(5),
          bottom = dpi(5),
          widget = wibox.container.margin
        }
      end

      if pct_remaining >= (100/(2*num_hearts)) then
          if charging then
            batl:add(hearts.charging.half)
          else batl:add(hearts.not_charging.half) end 
      else --[[batl:add(hearts.empty)]] end
    
  --[[    for i = 1, (num_hearts - 1) - wholes, 1 do
        batl:add(hearts.empty) end
        ]]--

      return wibox.widget {
        batl,
        top = dpi(5),
        bottom = dpi(5),
        widget = wibox.container.margin
      }
  end

  gears.timer {
    timeout = 11,
    call_now = true,
    autostart = true,
    callback = function()
      awful.spawn.easy_async_with_shell (
        -- This is more universal (I think it should work on BSD)
        -- [[
        --     search=$(upower -e | grep BAT);\
        --     power=$(upower -i $search);\
        --     echo "$power" | awk '/percentage/ {gsub("%",""); print $2}';\
        --     echo "$power" | awk '/state/ {gsub("%",""); print $2}'
        -- ]],
        [[
          dir="/sys/class/power_supply/BAT0" &&\
          cat $dir/capacity;\
          cat $dir/status
        ]],
        function (stdout, stderr)
          if stdout:match('error') then
              naughty.notify { text = "Can't read Battery.\nIs this a desktop?" }
          end

          local lines = {}
          for s in stdout:gmatch("[^\r\n]+") do
            table.insert(lines, s)
          end

          local hearts = get_hearts_widget(lines[1],lines[2])
          bat_pct = stdout
          local w = pi {
            widget = wibox.widget {
              hearts,
              widget = wibox.container.place
            },
            top = dpi(4),
            bottom = dpi(4),
            margins = dpi(2),
            -- shape = gears.shape.rounded_rect,
            outer = false
          }
              
          l:reset()
          l:add(w)
        end
      )
    end
  } --: start()

  l:connect_signal(
    'activate',
    function()
      local notif = naughty.notification {
        title = 'Battery',
        message = bat_pct:gsub("\n",' '), 
        icon = gears.color.recolor_image(gears.filesystem.get_configuration_dir() .. '/icons/heartbeat.svg',beautiful.wibar_fg),
      }

      -- wibox.widget {
      --   notification = notif,
      --   resize_strategy = 'center',
      --   widget = naughty.widget.icon
      -- }
      end
  )

  return clickable(l)
end

return power() 
