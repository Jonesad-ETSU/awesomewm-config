--[[
--  This is mostly just a rip-off of the default gtk theme by Yauhen Kirylau. Hand copied it to
--  (hopefully) gain a better understanding of it.
--]]
local theme_assets = require ('beautiful.theme_assets')
local gfs = require ('gears.filesystem')
local notif = require ('naughty').notify
local dpi = require ('beautiful.xresources').apply_dpi
local themes_path = gfs.get_themes_dir()
local wibox = require ('wibox')
local gtk = require ('beautiful.gtk')

notif { text = "Loading the thing"}

-- FUNCTIONS
local hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"
local function darker (color, darker_n)
    local result = '#'
    local channel_counter = 1
    for s in color:gmatch(hex_color_match) do
        local bg_numeric_value = tonumber("0x"..s)
        if channel_counter <= 3 then
            bg_numeric_value = bg_numeric_value - darker_n
        end
        if bg_numeric_value < 0 then bg_numeric_value = 0
        elseif bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x",bg_numeric_value)
        channel_counter = channel_counter + 1
    end
    return result 
end

local function is_dark(color)
    local bg_numeric_value = 0
    local channel_counter = 1
    for s  in color:gmatch(hex_color_match) do
        bg_numeric_value = bg_numeric_value + tonumber("0x"..s)
        if channel_counter == 3 then
            break
        end
        channel_counter = channel_counter + 1
    end
    local is_dark_bg = (bg_numeric_value < 383)
    return is_dark_bg
end

local function mix (c1, c2, ratio)
    ratio = ratio or 0.5
    local result = '#'
    local channels1 = c1:gmatch(hex_color_match)
    local channels2 = c2:gmatch(hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
            tonumber("0x"..channels1())*ratio +
            tonumber("0x"..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 
        elseif bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x",bg_numeric_value)
    end
    return result
end

local function reduce_contrast(color, ratio)
    ratio = ratio or 50
    return darker(color, is_dark(color) and -ratio or ratio)
end

local function choose_contrast_color(reference, candidate1, cnadidate2)
    if is_dark(reference) then
        if not is_dark(candidate1) then
            return candidate1 
        else return candidate2 end
    else
        if is_dark(candidate1) then
            return candidate1
        else return candidate2 end
end

-- END FUNCTIONS

-- Starts with Xresources file as backup.
local theme = dofile(themes_path.."xresources/theme.lua")
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
        local gdb = require ('gears.debug')
	gdb.print_warning("Can't load GTK theme. Using Xresources as fallback")
	return theme
end


theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
theme.gtk.button_border_width = dpi(theme.gtk.button_border_width or 1)
theme.gtk.bold_font = theme.gtk.font_family .. 'Bold' .. theme.gtk.font_size
theme.gtk.menubar_border_color = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.menubar_fg_color,
    0.7
)

theme.font_family = theme.gtk.font_family
theme.font_small = theme.gtk.font_family .. ' '..dpi(12)
theme.font_large = theme.gtk.font_family .. ' '..dpi(24)
theme.font_gtk = theme.gtk.font_family .. ' '..theme.gtk.font_size
theme.font = theme.gtk.font_family .. ' '..theme.gtk.font_size

theme.fg_normal= theme.gtk.fg_color
theme.bg_normal = theme.gtk.bg_color

theme.bg_focused = theme.gtk.selected_bg_color
theme.fg_focused = theme.gtk.selected_fg_color

theme.bg_urgent = theme.gtk.error_color
theme.fg_urgent = theme.gtk.bg_color

theme.wibar_bg = theme.gtk.base_color
theme.wibar_fg = theme.gtk.text_color

theme.bg_minimize = mix(theme.wibar_fg, theme.wibar_bg, .3)
theme.fg_minimize = mix(theme.wibar_fg, theme.wibar_bg, .9)

theme.bg_systray = theme.wibar_bg

theme.border_normal = theme.gtk.wm_border_unfocused_color
theme.border_focus = theme.gtk.wm_border_focused_color
theme.border_marked = theme.gtk.success_bg_color 

theme.border_width = dpi(theme.gtk.button_border_width or 1)
theme.border_radius = theme.gtk.button_border_radius

theme.useless_gap = dpi(5)

theme.roundness = 20
local rounded_rect_shape = function(cr,h,w)
	gears.shape.rounded_rect(cr,w,h,theme.roundness)
end

theme.tasklist_widget_template
theme.titlebar_font_normal = theme.gtk.bold_font
theme.titlebar_bg_normal = theme.gtk.wm_border_unfocused_color
theme.titlebar_fg_normal = theme.gtk.wm_title_unfocused_color

theme.titlebar_font_focus = theme.gtk.bold_font
theme.titlebar_bg_focus = theme.gtk.wm_border_focused_color
theme.titlebar_fg_focus = theme.gtk.wm_title_focused_color

theme.tooltip_fg = theme.gtk.tooltip_fg_color
theme.tooltip_bg = theme.gtk.tooltip_bg_color

theme.menu_border_width = theme.gtk.button_border_width
theme.menu_border_color = theme.gtk.menubar_border_color
theme.menu_bg_normal = theme.gtk.menubar_bg_color
theme.menu_fg_normal = theme.gtk.menubar_fg_color

theme.menu_height = dpi(24)
theme.menu_width = dpi(200)
theme.menu_submenu_icon = nil
theme.menu_submenu = "->"

-- DEFINE CUSTOM VARIABLES HERE --
theme.panel_item.bg = "#0000ff"
theme.panel_item.shape = rounded_rect_shape  
theme.panel_item.margins = dpi(10)
-- END VARIABLE DECLARATION ( cannot be done after recoloring) 

theme = theme_assets.recolor_layout(theme, theme.wibar_fg)

local rebar = theme_assets.recolor_layout
theme = rebar(theme, theme.wibar_fg_normal, "normal")
theme = rebar(theme, theme, reduce_contrast(theme.titlebar_fg_normal, 50), "normal", "hover") 
theme = rebar(theme, theme.gtk.error_bg_color, "normal", "press")
theme = rebar(theme, theme.titlebar_fg_focus, "focus")
theme = rebar(theme, reduce_contrast(theme.titlebar_fg_focus, 50), "focus", "hover")

theme.icon_theme = nil
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, mix(theme.bg_focus, theme.fg_normal), theme.wibar_bg	
)

notif { text = "Successfuly loaded theme"}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80:foldmethod=marker
