
function ftag(index)
    if index<6 then
        -- less the 6 are screen 1 tags
        s = screen[1]
    else
        -- all the other belong to screen 2
        s = screen[2]
        -- fixing the list index, since screen[2].tags[1] is the tag 6
        index = index-5
    end
    return index,s
end


function sharedviewtag(index)
    local i,s = ftag(index)
    local tag = s.tags[i]

    if tag then
        tag:view_only()
--        tag:raise()
    end
end


function sharedmovetag(index)
    local i,s = ftag(index)

    local c = client.focus
    if not c then return end

    c:move_to_tag(s.tags[i])
end

function sharedtoggletag(index)
    local i,s = ftag(index)

    local c = client.focus
    if not c then return end

    c:toggle_tag(s.tags[i])
end
