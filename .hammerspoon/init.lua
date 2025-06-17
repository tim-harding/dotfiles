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
