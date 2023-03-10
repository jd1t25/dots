local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = require("helpers")
local keys = require("keys")

local dock_autohide_delay = 0.5 -- seconds

-- {{{ Widgets
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.bg = beautiful.taglist_text_color_focused[index]
    elseif tag.urgent then
        item.bg = beautiful.taglist_text_color_urgent[index]
    elseif #tag:clients() > 0 then
        item.bg = beautiful.taglist_text_color_occupied[index]
    else
        item.bg = beautiful.taglist_text_color_empty[index]
    end
end

local dock = require("noodle.dock")
local dock_placement = function(w)
    return awful.placement.bottom(w)
end

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000" }

local tag_colors_urgent = { x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground }

local tag_colors_focused = {
    x.color1,
    x.color5,
    x.color4,
    x.color6,
    x.color2,
    x.color3,
    x.color1,
    x.color5,
    x.color4,
    x.color6,
}

local tag_colors_occupied = {
    x.color1.."45",
    x.color5.."45",
    x.color4.."45",
    x.color6.."45",
    x.color2.."45",
    x.color3.."45",
    x.color1.."45",
    x.color5.."45",
    x.color4.."45",
    x.color6.."45",
}

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.bg = tag_colors_focused[index]
    elseif tag.urgent then
        item.bg = tag_colors_urgent[index]
    elseif #tag:clients() > 0 then
        item.bg = tag_colors_occupied[index]
    else
        item.bg = tag_colors_empty[index]
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Create a taglist for every screen
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = {
            spacing = 10,
            spacing_widget = {
                color  = '#00ff00',
                shape  = gears.shape.circle,
                widget = wibox.widget.separator,
            },
            layout = wibox.layout.flex.horizontal,
        },
        widget_template = {
            widget = wibox.container.background,
            create_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
        }
    }

-- Create the taglist wibox
    s.taglist_box = awful.wibar({
        screen = s,
        visible = true,
        ontop = false,
        type = "dock",
        position = "top",
        height = dpi(10),
        -- position = "left",
        -- width = dpi(6),
        bg = "#00000000",
    })

    s.taglist_box:setup {
        widget = s.mytaglist,
    }



    -- Create a system tray widget
    s.systray = wibox.widget.systray()
    -- Create the tray box
    s.traybox = wibox({ screen = s, width = dpi(150), height = beautiful.wibar_height, bg = "#00000000", visible = false, ontop = true})
    s.traybox:setup {
        {
            {
                nil,
                s.systray,
                expand = "none",
                layout = wibox.layout.align.horizontal,
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_systray,
        shape = helpers.rrect(beautiful.border_radius),
        widget = wibox.container.background
    }
    awful.placement.bottom_right(s.traybox, { margins = beautiful.useless_gap * 2 })
    s.traybox:buttons(gears.table.join(
        awful.button({ }, 2, function ()
            s.traybox.visible = false
        end)
    ))
end)

awesome.connect_signal("elemental::dismiss", function()
    local s = mouse.screen
    s.dock.visible = false
end)

-- Every bar theme should provide these fuctions
function wibars_toggle()
    local s = awful.screen.focused()
    s.dock.visible = not s.dock.visible
end
function tray_toggle()
    local s = awful.screen.focused()
    s.traybox.visible = not s.traybox.visible
end
