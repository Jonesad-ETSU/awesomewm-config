local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return  ib ({
        image = gfs.get_configuration_dir() .. 'widget/button/terminal/terminal.svg',
        hide_tooltip = true, 
        cmd = "$TERM",
})
