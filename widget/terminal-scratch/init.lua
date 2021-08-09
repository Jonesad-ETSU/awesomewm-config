pcall (require, 'luarocks.loader')

local awful = require ('awful')
local beautiful = require ('beautiful')
local bling = require ("bling")
local awestore = require ('awestore')

local screen = {
    width = awful.screen.focused().geometry.width,
    height = awful.screen.focused().geometry.height
}

local anim_y = awestore.tweened (
    screen.height,
    {
        duration = 350,
        easing = awestore.easing.cubic_in_out
    }
) 

local scratch = bling.module.scratchpad:new({
    command = 'wezterm start --class spad',
    rule = { instance = 'spad' },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {
        x=0,
        y=screen.height,
        height=screen.height,
        width= screen.width
    },
    reapply = true,
    dont_focus_before_close = false,
    awestore = { y = anim_y }
})

scratch:toggle()

return scratch
