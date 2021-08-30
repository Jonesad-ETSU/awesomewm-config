local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local color = require ('gears.color')

return  ib ({
        image = color.recolor_image(gfs.get_configuration_dir() .. 'widget/button/wall/wall.svg',"#ffffff"),
        hide_tooltip = true, 
        cmd = "nitrogen",
})
