local top = require ('layout.top')

require('awful').screen.connect_for_each_screen (
    function(s)
        s.top_panel = top(s)
    end
)

function update()
    for s in screen do
        if s.selected_tag then
            local fullscreen = s.selected_tag.fullscreen_mode
            if s.top_panel then
                s.top_panel.visible = not fullscreen
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

return top_panel
