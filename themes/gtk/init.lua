----------------------------------------------
-- Awesome theme which follows GTK+ 3 theme --
--   by Yauhen Kirylau                      --
----------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gtk = beautiful.gtk
local gears = require("gears")
local gfs = gears.filesystem
local themes_path = gfs.get_themes_dir()
local id = gfs.get_configuration_dir() .. '/icons/'

-- Helper functions for modifying hex colors:
--
local hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"
local function darker(color_value, darker_n)
    local result = "#"
    local channel_counter = 1
    for s in color_value:gmatch(hex_color_match) do
        local bg_numeric_value = tonumber("0x"..s)
        if channel_counter <= 3 then
            bg_numeric_value = bg_numeric_value - darker_n
        end
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
        channel_counter = channel_counter + 1
    end
    return result
end
local function is_dark(color_value)
    local bg_numeric_value = 0;
    local channel_counter = 1
    for s in color_value:gmatch(hex_color_match) do
        bg_numeric_value = bg_numeric_value + tonumber("0x"..s);
        if channel_counter == 3 then
            break
        end
        channel_counter = channel_counter + 1
    end
    local is_dark_bg = (bg_numeric_value < 383)
    return is_dark_bg
end
local function mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(hex_color_match)
    local channels2 = color2:gmatch(hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
          tonumber("0x"..channels1())*ratio +
          tonumber("0x"..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
    end
    return result
end
local function reduce_contrast(color, ratio)
    ratio = ratio or 50
    return darker(color, is_dark(color) and -ratio or ratio)
end

local function choose_contrast_color(reference, candidate1, candidate2)  -- luacheck: no unused
    if is_dark(reference) then
        if not is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    else
        if is_dark(candidate1) then
            return candidate1
        else
            return candidate2
        end
    end
end


-- inherit xresources theme:
local theme = dofile(themes_path.."xresources/theme.lua")
-- load and prepare for use gtk theme:
theme.gtk = gtk.get_theme_variables()
if not theme.gtk then
    local gears_debug = require("gears.debug")
    gears_debug.print_warning("Can't load GTK+3 theme. Using 'xresources' theme as a fallback.")
    return theme
end

theme.is_dark = is_dark
theme.mix = mix
theme.darker = darker
theme.reduce_contrast = reduce_contrast
theme.choose_contrast_color = choose_contrast_color

theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
theme.gtk.button_border_width = dpi(theme.gtk.button_border_width or 1)
theme.gtk.bold_font = theme.gtk.font_family .. ' Bold ' .. theme.gtk.font_size
theme.gtk.menubar_border_color = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.menubar_fg_color,
    0.7
)


local function set_opacity(s,op)
    return string.sub(s,1,7) .. op
end
theme.transparent = '#00000000'
theme.opacity = 'fa'
theme.font          = theme.gtk.font_family .. ' ' .. theme.gtk.font_size
theme.tiny_font          = theme.gtk.font_family .. ' ' .. dpi(4)
-- theme.small_font          = theme.gtk.font_family .. ' ' .. dpi(5)
theme.small_font          = theme.gtk.font_family .. ' 8'
theme.medium_font          = theme.gtk.font_family .. ' ' .. dpi(8)
theme.large_font          = theme.gtk.font_family .. ' ' .. dpi(10)
theme.extra_large_font          = theme.gtk.font_family .. ' ' .. dpi(24)
theme.font_family   = theme.gtk.font_family

theme.bg_normal     = theme.gtk.bg_color
theme.fg_normal     = theme.gtk.fg_color

-- theme.wibar_bg      = set_opacity(theme.gtk.menubar_bg_color,theme.opacity)
theme.wibar_bg      = set_opacity(theme.gtk.bg_color,theme.opacity)
theme.wibar_fg      = theme.gtk.menubar_fg_color

theme.bg_focus      = theme.gtk.fg_color
theme.fg_focus      = theme.gtk.bg_color

theme.bg_menubar      = theme.gtk.fg_color
theme.fg_menubar      = theme.gtk.bg_color

theme.bg_header      = theme.gtk.header_button_bg_color
theme.fg_header      = theme.gtk.header_button_fg_color
theme.border_header  = theme.gtk.header_button_border_color

theme.bg_select     = theme.gtk.selected_bg_color
theme.fg_select     = theme.gtk.selected_fg_color

theme.bg_urgent     = theme.gtk.error_bg_color
theme.fg_urgent     = theme.gtk.error_fg_color

theme.success     = theme.gtk.success_color

theme.bg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.3)
theme.fg_minimize   = mix(theme.wibar_fg, theme.wibar_bg, 0.9)

-- theme.bg_systray    = theme.wibar_bg
-- theme.bg_systray    = set_opacity(theme.wibar_bg,"00")

theme.border_normal = theme.gtk.wm_border_unfocused_color
theme.border_focus  = mix (
    theme.gtk.fg_color, theme.gtk.bg_color, .1
)
theme.border_marked = theme.gtk.success_color

theme.border_width  = dpi(theme.gtk.button_border_width or 1)
theme.border_radius = theme.gtk.button_border_radius
theme.border_color  = theme.gtk.button_border_color

--theme.useless_gap   = 100

local rounded_rect_shape = function(cr,w,h)
    local radius
    if theme.border_radius == 0 then
        radius = 0
    else 
        radius = theme.border_radius + 10
    end
    return gears.shape.rounded_rect(
        cr, w, h, radius
    )
end

theme.rounded_rect_shape = rounded_rect_shape

theme.tasklist_fg_normal = theme.wibar_fg
theme.tasklist_bg_normal = theme.wibar_bg
theme.tasklist_bg_focus = darker(theme.tasklist_bg_normal,150)
theme.tasklist_fg_focus = theme.tasklist_fg_normal

theme.tasklist_font_focus = theme.gtk.bold_font

theme.tasklist_shape_minimized = rounded_rect_shape
theme.tasklist_shape_border_color_minimized = mix(
    theme.bg_minimize,
    theme.fg_minimize,
    0.85
)
theme.tasklist_shape_border_width_minimized = theme.gtk.button_border_width

theme.tasklist_spacing = theme.gtk.button_border_width

-- --[[ Advanced taglist and tasklist styling: {{{
-- 
-- --- In order to get taglist and tasklist to follow GTK theme you need to
-- -- modify your rc.lua in the following way:
-- 
-- diff --git a/rc.lua b/rc.lua
-- index 231a2f68c..533a859d2 100644
-- --- a/rc.lua
-- +++ b/rc.lua
-- @@ -217,24 +217,12 @@ awful.screen.connect_for_each_screen(function(s)
--          filter  = awful.widget.taglist.filter.all,
--          buttons = taglist_buttons
--      }
-- +    -- and apply shape to it
-- +    if beautiful.taglist_shape_container then
-- +        local background_shape_wrapper = wibox.container.background(s.mytaglist)
-- +        background_shape_wrapper._do_taglist_update_now = s.mytaglist._do_taglist_update_now
-- +        background_shape_wrapper._do_taglist_update = s.mytaglist._do_taglist_update
-- +        background_shape_wrapper.shape = beautiful.taglist_shape_container
-- +        background_shape_wrapper.shape_clip = beautiful.taglist_shape_clip_container
-- +        background_shape_wrapper.shape_border_width = beautiful.taglist_shape_border_width_container
-- +        background_shape_wrapper.shape_border_color = beautiful.taglist_shape_border_color_container
-- +        s.mytaglist = background_shape_wrapper
-- +    end
-- 
--      -- Create a tasklist widget
--      s.mytasklist = awful.widget.tasklist {
--          screen  = s,
--          filter  = awful.widget.tasklist.filter.currenttags,
-- +        buttons = tasklist_buttons,
-- +        widget_template = beautiful.tasklist_widget_template
-- -        buttons = tasklist_buttons
--      }
-- 
-- --]]
-- theme.tasklist_widget_template = {
--     {
--         {
--             {
--                 {
--                     id     = 'clienticon',
--                     widget = awful.widget.clienticon,
--                 },
--                 margins = dpi(4),
--                 widget  = wibox.container.margin,
--             },
--             {
--                 id     = 'text_role',
--                 widget = wibox.widget.textbox,
--             },
--             layout = wibox.layout.fixed.horizontal,
--         },
--         left  = dpi(2),
--         right = dpi(4),
--         widget = wibox.container.margin
--     },
--     id     = 'background_role',
--     widget = wibox.container.background,
--     create_callback = function(self, c)
--         self:get_children_by_id('clienticon')[1].client = c
--     end,
-- }
-- 
-- theme.taglist_shape_container = rounded_rect_shape
-- theme.taglist_shape_clip_container = true
-- theme.taglist_shape_border_width_container = theme.gtk.button_border_width * 2
-- theme.taglist_shape_border_color_container = theme.gtk.header_button_border_color
-- -- }}}
-- 
theme.taglist_bg_occupied = theme.gtk.header_button_bg_color
theme.taglist_fg_occupied = theme.gtk.header_button_fg_color

theme.taglist_bg_empty = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.header_button_bg_color,
    0.3
)
theme.taglist_fg_empty = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.header_button_fg_color
)
--]]
theme.titlebar_font_normal = theme.gtk.bold_font
theme.titlebar_bg_normal = theme.gtk.wm_border_unfocused_color
theme.titlebar_fg_normal = theme.gtk.wm_title_unfocused_color
theme.titlebar_font_focus = theme.gtk.bold_font
theme.titlebar_bg_focus = theme.gtk.wm_border_focused_color
theme.titlebar_fg_focus = theme.gtk.wm_title_focused_color
theme.titlebar_button_gap = dpi(3)

theme.titlebar_close_button_normal = id .. '/close.svg'
theme.titlebar_minimize_button_normal = id .. '/minimize.svg'
theme.titlebar_maximized_button_normal_active = id .. '/window-restore.svg'
theme.titlebar_maximized_button_normal_inactive = id .. '/maximize.svg'
theme.titlebar_close_button_normal_hover = id .. '/close.svg'
theme.titlebar_minimize_button_normal_hover = id .. '/minimize.svg'
theme.titlebar_maximized_button_normal_active_hover = id .. '/window-restore.svg'
theme.titlebar_maximized_button_normal_inactive_hover = id .. '/maximize.svg'
theme.titlebar_close_button_normal_press = id .. '/close.svg'
theme.titlebar_minimize_button_normal_press = id .. '/minimize.svg'
theme.titlebar_maximized_button_normal_active_press = id .. '/window-restore.svg'
theme.titlebar_maximized_button_normal_inactive_press = id .. '/maximize.svg'

theme.titlebar_close_button_focus = id .. '/close.svg'
theme.titlebar_minimize_button_focus = id .. '/minimize.svg'
theme.titlebar_maximized_button_focus_active = id .. '/window-restore.svg'
theme.titlebar_maximized_button_focus_inactive = id .. '/maximize.svg'
theme.titlebar_close_button_focus_hover = id .. '/close.svg'
theme.titlebar_minimize_button_focus_hover = id .. '/minimize.svg'
theme.titlebar_maximized_button_focus_active_hover = id .. '/window-restore.svg'
theme.titlebar_maximized_button_focus_inactive_hover = id .. '/maximize.svg'
theme.titlebar_close_button_focus_press = id .. '/close.svg'
theme.titlebar_minimize_button_focus_press = id .. '/minimize.svg'
theme.titlebar_maximized_button_focus_active_press = id .. '/window-restore.svg'
theme.titlebar_maximized_button_focus_inactive_press = id .. '/maximize.svg'

theme.tooltip_fg = theme.gtk.tooltip_fg_color
theme.tooltip_bg = theme.gtk.tooltip_bg_color

theme.menu_border_width = theme.gtk.button_border_width
theme.menu_border_color = theme.gtk.menubar_border_color
theme.menu_bg_normal = theme.gtk.menubar_bg_color
theme.menu_fg_normal = theme.gtk.menubar_fg_color

theme.menu_height = dpi(24)
theme.menu_width  = dpi(200)
theme.menu_submenu_icon = nil
theme.menu_submenu = "->"

theme.client_shape = function(c,w,h)
    return gears.shape.rounded_rect(c,w,h,theme.button_border_radius)
end

theme.tooltip_shape = rounded_rect_shape

theme.panel = {}
    theme.panel.side = 'top'
    theme.panel.width = dpi(1000)
    theme.panel.height = theme.panel.width/4.5
    theme.panel.border_width = dpi(2)
    theme.panel.border_color = reduce_contrast(theme.wibar_bg,-10)
    theme.panel.shape = theme.rounded_rect_shape
    theme.panel.fg = theme.wibar_fg
    theme.panel.bg = theme.wibar_bg
    theme.panel.items_spacing = dpi(8)

theme.panel_item = {}
    -- theme.panel_item.bg = set_opacity(reduce_contrast(theme.gtk.menubar_bg_color,-5),'66')
    -- theme.panel_item.button_bg = set_opacity(reduce_contrast(theme.panel_item.bg, -3),'44')
    -- theme.panel_item.bg = reduce_contrast(theme.gtk.button_bg_color,0)
    theme.panel_item.bg = reduce_contrast(theme.wibar_bg,5)
    -- theme.panel_item.bg = set_opacity(theme.gtk.button_bg_color,'aa')
    -- theme.panel_item.button_bg = set_opacity(theme.gtk.header_button_bg_color,'66')
    theme.panel_item.button_bg = theme.panel.bg 
    theme.panel_item.name_bg = reduce_contrast(theme.panel.bg,0)
    -- theme.panel_item.highlight = reduce_contrast(theme.panel_item.bg,25)
    theme.panel_item.highlight = set_opacity(theme.bg_select,'aa')
    theme.panel_item.border_color = set_opacity(theme.gtk.button_border_radius,'ee')
    theme.panel_item.border_width = theme.gtk.button_border_width or 10
    -- theme.panel_item.border_width = 10
    -- theme.panel_item.border_width = dpi(1) -- uncomment for borders
    theme.panel_item.shape = rounded_rect_shape
    theme.panel_item.margins = dpi(10)

theme.bg_systray    = theme.panel_item.bg
-- theme.bg_systray = "#00000000"
theme.systray_icon_spacing = dpi(3)

theme.notification_icon_resize_strategy = 'scale'
-- theme.notification_icon_resize_strategy = 'center'
-- theme.notification_icon_size = 512
-- theme.notification_icon_size = dpi(64)

theme = theme_assets.recolor_layout(theme, theme.wibar_fg)

theme = theme_assets.recolor_titlebar(
    theme, theme.titlebar_fg_normal, "normal"
)
theme = theme_assets.recolor_titlebar(
    theme, reduce_contrast(theme.titlebar_fg_normal, 50), "normal", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.gtk.error_bg_color, "normal", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.titlebar_fg_focus, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, reduce_contrast(theme.titlebar_fg_focus, 50), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.gtk.error_bg_color, "focus", "press"
)
theme.icon_theme = nil

theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, mix(theme.bg_focus, theme.fg_normal), theme.wibar_bg
)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80:foldmethod=marker
