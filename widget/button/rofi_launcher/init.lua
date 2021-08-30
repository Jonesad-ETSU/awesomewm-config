local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local gears = require ('gears')
local beautiful = require ('beautiful')

return ib ({
    image = gears.color.recolor_image(gfs.get_configuration_dir() .. '/widget/button/rofi_launcher/rofi.svg',"#ffffff"),
    cmd = "rofi -show drun",
    tooltip = "Run Application Launcher"
})
