local panel = require ('layout.panel')
local time = require ('layout.time')
-- local awful = require ('awful')

require('awful').screen.connect_for_each_screen (
    function(s)
        s.time = time(s)
        s.panel = panel(s,'top')
    end
)

function update()
    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreen_mode
            if s.panel then
                s.panel.visible = not fullscreen
            end
            if s.time then
              s.time.visible = not fullscreen
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
