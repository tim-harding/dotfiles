#! /usr/bin/env fish
set fullscreen $(hyprctl activewindow -j | jq .fullscreen)
if test $fullscreen = 'true'
    set monitor $(hyprctl activewindow -j | jq .monitor)
    if test $monitor = 0
        hyprctl dispatch workspace +1
    else
        hyprctl dispatch movefocus r
    end
else
    hyprctl dispatch movefocus r
end
