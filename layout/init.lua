local panel = require ('layout.panel')
local time = require ('layout.time')
local tags = require ('layout.tags')
local beautiful = require ('beautiful')
local side = beautiful.panel.side

require('awful').screen.connect_for_each_screen (
    function(s)
      -- local aux = auxilary(s,side)
      -- s.time = tags(s,side)
      s.time = time(s,side)
      s.tag_box = tags(s,side)
      -- s.time, s.tags = aux.time, aux.tags 
      s.panel = panel(s,side)
    end
)

local function update()
    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreen_mode
            if s.panel then
              s.panel.visible = not fullscreen
            end
            if s.time and fullscreen then
              -- Prevents glitch where time shows up at the same time as the panel
              s.time.visible = false
            end
            if s.tag_box and fullscreen then 
              s.tag_box.visible = false
            end
        end
    end
end

tag.connect_signal(
    'property::selected',
    function() update() end
)

client.connect_signal(
    'property::fullscreen',
    function(c)
        if c.first_tag then
            c.first_tag.fullscreen_mode = c.fullscreen
        end
        update()
    end
)

client.connect_signal(
    'unmanage',
    function(c)
        if c.fullscreen then
            c.screen.selected_tag.fullscreen_mode = false
            update()
        end
    end
)

--return top_panel
