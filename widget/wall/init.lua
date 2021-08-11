local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return  ib ({
        image = gfs.get_configuration_dir() .. 'widget/wall/wall.svg',
        bg = '#0000ff',
        cmd = "nitrogen",
        --stdout_cmd = '',
})
