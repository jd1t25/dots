local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local helpers = require("helpers")


-- For antialiasing
-- The real background color is set in the widget_template
beautiful.notification_bg = "#00000000"

local app_config = {
    ['volume'] = { icon = "", title = false },
    ['brightness'] = { icon = "", title = false },
    ['screenshot'] = { icon = "", title = false },
    ['Telegram Desktop'] = { icon = "", title = true },
    ['NetworkManager'] = { icon = "", title = true },
    ['youtube'] = { icon = "", title = true },
    ['mpd'] = { icon = "", title = true },
    ['mpv'] = { icon = "", title = true },
}


local urgency_color = {
    ['low'] = x.color2,
    ['normal'] = x.color4,
    ['critical'] = x.color11,
}
