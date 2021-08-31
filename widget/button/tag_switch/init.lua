local ib = require ('widget.util.img_button')
local gfs = require ('gears.filesystem')
local recolor = require ('gears.color').recolor_image

return ib ({
	image = recolor(gfs.get_configuration_dir() .. '/widget/button/tag_switch/tag.svg','#ffffff'),
	show_widget = "widget.tag_switch",
	tooltip = 'Show tag-switch widget'
})
