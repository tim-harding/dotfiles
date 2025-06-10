hs.hotkey.bind({"cmd", "alt"}, "Right", function()
    hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind({"cmd", "alt"}, "Left", function()
    hs.window.focusedWindow():focusWindowWest()
end)

hs.hotkey.bind({"cmd", "alt"}, "Up", function()
    hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind({"cmd", "alt"}, "Down", function()
    hs.window.focusedWindow():focusWindowSouth()
end)
