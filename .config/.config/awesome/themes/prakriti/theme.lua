--{{{
    
--    https://media.giphy.com/media/eh7hUnxUFRt1mCahfI/giphy.gif

--}}}

local awful = require("awful")
local gears = require("gears")
local theme_name = "indradhanush"
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()
-- local theme = dofile(themes_path.."default/theme.lua")
local theme = {}

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars  etc.
theme.font          = "monospace 11"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

local green = "#8dd69a"

-- Gaps
theme.useless_gap   = dpi(2)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(5)

-- Borders
theme.border_width  = dpi(2)
-- theme.border_color = x.color0
theme.border_normal = x.background
theme.border_focus  = green
-- Rounded corners
theme.border_radius = dpi(10)



-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = true
theme.titlebar_size = dpi(35)
theme.titlebar_title_enabled = false
theme.titlebar_font = "sans bold 9"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
theme.titlebar_bg = x.background
-- theme.titlebar_bg_focus = x.color12
-- theme.titlebar_bg_normal = x.color8
theme.titlebar_fg_focus = x.background
theme.titlebar_fg_normal = x.color8
--theme.titlebar_fg = x.color7


return theme

