#!/usr/bin/fish --no-config

set screen_and_window $(swaymsg -t get_tree | ~/.config/sway/next_fullscreen.jq)

if set -q screen_and_window[1]
    set screen $screen_and_window[1]
    set window $screen_and_window[2]

    switch $argv[1]
    case 'left'
        set toggle_screen 'DP-2'
    case 'right'
        set toggle_screen 'DP-3'
    end

    if test $screen = $toggle_screen
        swaymsg swap container with con_id $window
    else
        swaymsg focus $argv[1]
    end
else
    swaymsg focus $argv[1]
end
