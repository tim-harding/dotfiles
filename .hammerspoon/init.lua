hs.hotkey.bind({"ctrl", "shift"}, "Right", function()
    hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind({"ctrl", "shift"}, "Left", function()
    hs.window.focusedWindow():focusWindowWest()
end)

hs.hotkey.bind({"ctrl", "shift"}, "Up", function()
    hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind({"ctrl", "shift"}, "Down", function()
    hs.window.focusedWindow():focusWindowSouth()
end)


---------------------------------------------------------------------------------------------------
-- https://superuser.com/questions/303424/can-i-enable-scrolling-with-middle-button-drag-in-os-x --
---------------------------------------------------------------------------------------------------
local scrollMouseButton = 2
local deferred = false

local overrideOtherMouseDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if scrollMouseButton == pressedMouseButton
        then
            deferred = true
            return true
        end
end)

local overrideOtherMouseUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if scrollMouseButton == pressedMouseButton
        then
            if (deferred) then
                overrideOtherMouseDown:stop()
                overrideOtherMouseUp:stop()
                hs.eventtap.otherClick(e:location(), pressedMouseButton)
                overrideOtherMouseDown:start()
                overrideOtherMouseUp:start()
                return true
            end
            return false
        end
        return false
end)

local oldmousepos = {}
local scrollmult = -4

local dragOtherToScroll = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if scrollMouseButton == pressedMouseButton
        then
            deferred = false
            oldmousepos = hs.mouse.getAbsolutePosition()
            local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
            local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
            local scroll = hs.eventtap.event.newScrollEvent({-dx * scrollmult, dy * scrollmult},{},'pixel')
            hs.mouse.setAbsolutePosition(oldmousepos)
            return true, {scroll}
        else
            return false, {}
        end
end)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()
