local wibox = require ('wibox')
local awful = require ('awful')
local gears = require ('gears')
local awestore = require ('awestore')
local clickable = require ('widget.util.clickable')
local beautiful = require ('beautiful')
local naughty = require ('naughty')
local dpi = require ('beautiful.xresources').apply_dpi

--[[
--  bar_widget function
--  optional param: options = {
--      init_value 
--      bar_shape => shape of the progressed bar
--      shape => shape of the overall bar
--      bar_border_color => color of progressed bar's border
--      bar_border_width => width of progressed bar's border
--      border_color => color of progress bar's border
--      border_width => width of progress bar's border
--      min_value 
--      max_value
--      color => color for progressed bar
--      cmd [mandatory]=> command to get bar's progession value/percentage
--      activate_function => function to call on click
--      label_text 
--      label_widget => widget override for label
--      anim_duration
--      anim_easing => how the animation progresses
--      alt_check => function to determine whether the bar should change to alt color (think mute changing bar color red)
--      alt_color => alternate color for bar
--      timer => update interval
--  }
--
--]]
local bar_widget = function (options)


    local bar = wibox.widget {
        value = options.init_value or 50,
        max_value = options.max_value or 100,
        bar_shape = options.bar_shape or gears.shape.rounded_bar,
        shape = options.shape or gears.shape.rounded_bar, 
        bar_border_color = options.bar_border_color or nil,
        bar_border_width = options.bar_border_width or 1,
        border_width = options.border_width or 2,
        border_color = options.border_color or "#00ffff",
        forced_width = options.forced_width or dpi(100),
        forced_height = options.forced_height or dpi(1),
        color = options.color or "#00ff00",
        background_color = options.background_color or "#282828",
        --paddings = 1,
        widget = wibox.widget.progressbar
    }

    if options.tooltip then
      awful.tooltip {
        objects = { bar },
        delay_show = 1,
        text = options.tooltip
      }
    end

    local pct = wibox.widget {
        markup = "N/A",
        align = 'left',
        font = options.font or beautiful.font,
        widget = wibox.widget.textbox
    }

    local anim_stats = {
	duration = options.anim_duration or 600,
	easing = options.anim_easing or awestore.linear
    }

    local anim = awestore.tweened(0, anim_stats)

    anim:subscribe (
      function(val)
        bar.value = val
        pct.markup = math.floor(val)
      end
    )

    local cmd = options.cmd or [[echo $(( $RANDOM % 100 )) ]]
    -- local anim_duration = options.anim_duration

    local function update()
            awful.spawn.easy_async_with_shell (
                cmd,
                function(stdout)
                   local lines = {}
                   for s in stdout:gmatch("[^\r\n]+") do
                        table.insert(lines,s)
                   end
                   if options.alt_check and options.alt_check(lines) then
                        bar.color = options.alt_color or "#ff0000"
                    else
                        bar.color = options.color or "#00ff00"
                  end
		   local value = tonumber(lines[1])
		   --anim_stats.duration = anim_duration * (value/100)
                   anim:set(value)
		   --anim_stats.duration = options.anim_duration
                end
            )
    end

    gears.timer {
        timeout = options.timer or 17,
        call_now = true,
        autostart = true,
	callback = function()
          update()
    	end
    } : start()


    local text = wibox.widget {
        markup = options.label_text or '<b>LABEL:</b> ',
        align = 'center',
        font = beautiful.font,
        widget = wibox.widget.textbox,
    }

    local ratio = wibox.layout.ratio.horizontal()
    local stack = wibox.layout.stack()
    ratio.spacing = options.elem_spacing or dpi(5)

    ratio:add (
	options.label_widget or wibox.widget {
            text,
            fg = options.text_fg or beautiful.wibar_fg,
            widget = wibox.container.background
        }
    )

    if options.stack_pct == true then
        stack:add (
            bar,
            wibox.widget {
                pct,
                fg = options.text_fg or "#ffffff",
                widget = wibox.container.background
            })
	ratio:add(stack)
    else
        ratio:add (
            bar,
            wibox.widget {
                pct,
                fg = options.text_fg or "#ffffff",
                widget = wibox.container.background
            })
    end

    if options.ratio then
	    ratio:ajust_ratio( 2, options.ratio[1], options.ratio[2], options.ratio[3] )
    else ratio:ajust_ratio( 2, .175, .65, .175 ) end

    ratio:connect_signal(
        'activate',
        function()
            if options.activate_function then
                options.activate_function()
            elseif not options.buttons then 
		    naughty.notify { text = "You clicked me! :D " }
	    end
        end
    )

    if options.buttons then
	    local final = clickable( ratio, options.buttons )
            return final
    end

    return clickable(ratio)
end

return bar_widget
