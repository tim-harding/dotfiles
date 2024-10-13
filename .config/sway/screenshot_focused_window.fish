#!/usr/bin/fish --no-config

set grimfile ~/screenshots/$(date +'%s_grim.png')

swaymsg -t get_tree | 
    ~/.config/sway/focused_window.jq |
    grim -g - $grimfile
