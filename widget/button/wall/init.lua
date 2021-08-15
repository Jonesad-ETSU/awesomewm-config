local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return  ib ({
        image = gfs.get_configuration_dir() .. 'widget/button/wall/wall.svg',
        hide_tooltip = true, 
        cmd = "nitrogen",
})
