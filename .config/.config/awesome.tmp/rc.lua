--[[

 This file says ->  "https://media.giphy.com/media/KEYEpIngcmXlHetDqz/giphy.gif"

--]] 


-- User variables and preferences
user = {
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    editor = "kitty -1 --class editor -e vim",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },
}

-- Initialization
-- ===================================================================
-- Theme handling library
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi
-- Make xresources colors global
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

-- Load AwesomeWM libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Rule Libraries
local ruled = require("ruled")
-- Default notification library
local naughty = require("naughty")

-- Load theme
--local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/"
--beautiful.init(theme_dir .. "theme.lua")
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")


-- Features
-- ===================================================================
-- Keybinds and mousebinds
local keys = require("keys")
-- Shared Tags
local sharedtags = require("sharedtags")
-- Taglist / Bar 
require("bar")


-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw,
    })
end)
-- }}}



-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
--                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Add titlebars to normal clients and dialogs
    --ruled.client.append_rule {
    --    id         = "titlebars",
    --    rule_any   = { type = { "normal", "dialog" } },
    --    properties = { titlebars_enabled = true      }
    --}

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)



-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)


-- Error handling
-- ===================================================================
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)



awful.spawn.with_shell("~/bin/autostart.sh")
awful.spawn.with_shell("feh --bg-scale Wallpapers/fireworks_by_bisbiswas_dempx5a.jpg Wallpapers/verdant_mountain_by_bisbiswas_derlepn.jpg")

