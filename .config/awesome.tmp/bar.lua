local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")
local sharedtags = require("sharedtags")


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


--local tags = sharedtags({ 
--        {"1", "2", "3", "4", "5"}, screen = 1, awful.layout.layouts[1]
--        {"6", "7", "8", "9"}, screen = 2, awful.layout.layouts[1]
--})

local tags = sharedtags({   {"1", screen = 1, awful.layout.layouts[1] },
                            {"2", screen = 1, awful.layout.layouts[1] },
                            {"3", screen = 1, awful.layout.layouts[1] },
                            {"4", screen = 1, awful.layout.layouts[1] },
                            {"5", screen = 1, awful.layout.layouts[1] },
                            {"6", screen = 2, awful.layout.layouts[1] },
                            {"7", screen = 2, awful.layout.layouts[1] },
                            {"8", screen = 2, awful.layout.layouts[1] },
                            {"9", screen = 2, awful.layout.layouts[1] }
})


screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
--    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    if s.index==1 then
        awful.tag({ "1 ", "2", "3", "4", "5" }, screen[1], awful.layout.layouts[1])
    elseif s.index==2 then
        awful.tag({ "6", "7", "8", "9" }, screen[2], awful.layout.layouts[1])
    end

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = keys.taglist_buttons,
        layout = {
            spacing = 0,
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

    s.taglist_box = awful.wibar({
        screen = s,
        visible = true,
        ontop = false,
        type = "dock",
        position = "top",
        height = dpi(6),
        -- position = "left",
        -- width = dpi(6),
        bg = "#00000000",
    })

    s.taglist_box:setup {
        widget = s.mytaglist,
    }
end)

return(bar)
