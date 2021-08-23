local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')

return ib ({
	image = gfs.get_configuration_dir() .. '/widget/button/tag_switch/tag_switch.svg',
	show_widget = "widget.tag_switch",
	tooltip = 'Show tag-switch widget'
})
