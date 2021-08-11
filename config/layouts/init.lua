local awful = require ('awful')
local bling = require ('bling')
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.magnifier,
    bling.layout.centered,
    bling.layout.mstab,
    bling.layout.equalarea,
}
