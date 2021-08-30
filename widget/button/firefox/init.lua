local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local color = require ('gears.color')

return ib ({
    image = gfs.get_configuration_dir() .. '/widget/button/firefox/firefox.svg',
    cmd = "firefox",
})
