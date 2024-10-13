#!/usr/bin/fish --no-config

swaymsg --type get_outputs | 
    ~/.config/sway/rotation.jq |
    read rotation

if test $rotation = "270"
    swaymsg output DP-3 position 1920 0
    swaymsg output DP-2 transform 0
else
    swaymsg output DP-3 position 1200 0
    swaymsg output DP-2 transform 270
end
