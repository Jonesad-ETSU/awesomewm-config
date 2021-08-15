local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return ib ({
    image = gfs.get_configuration_dir() .. '/widget/button/rofi_launcher/rofi.svg',
    cmd = "rofi -show drun -theme ~/.config/rofi/theme.css -icon-theme 'Papirus-Dark' -show-icons",
    tooltip = "Run Application Launcher"
})
