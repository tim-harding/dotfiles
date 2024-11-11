#!/usr/bin/env -S fish --no-config

if test (hyprctl activewindow -j | jq .fullscreen) -eq 0
    echo tiled
    hyprctl dispatch setfloating
    hyprctl dispatch resizeactive exact 100% 100%
    hyprctl dispatch centerwindow
    hyprctl dispatch fullscreenstate 3
else
    hyprctl dispatch fullscreenstate 0
    hyprctl dispatch settiled
end
