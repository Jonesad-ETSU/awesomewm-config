local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return ib ({
	image = gfs.get_configuration_dir() .. '/widget/button/power/power.svg',
	show_widget = "widget.power_popup",
	tooltip	= "Open Shutdown prompt"
})
