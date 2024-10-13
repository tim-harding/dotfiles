#!/usr/bin/fish --no-config

set grimfile ~/screenshots/$(date +'%s_grim.png')

swaymsg -t get_outputs |
    ~/.config/sway/focused_monitor.jq |
    read monitor

grim -o $monitor $grimfile
