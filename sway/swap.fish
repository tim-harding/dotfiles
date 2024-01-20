#!/usr/bin/fish --no-config

set screen_and_window $(swaymsg -t get_tree | \
jq -r "\
.nodes[] |
select(.active?) |
{
    name,
    workspaces: (
        .nodes |
        map(
            .nodes |
            walk(
                if type==\"object\" then
                    if has(\"app_id\") then
                        .id, (.focused and .fullscreen_mode==1)
                    elif .type?==\"monitor\" then
                        \"hi\"
                    else
                        .nodes[]?
                    end
                else
                    .
                end
            )
        )
    )
} |
{
    name,
    next_window: (
        .workspaces[] |
        [index(true), length, .] | 
        .[2][(.[0] + 1) % .[1]]
    )
} |
select(.next_window | type==\"number\") |
.name, .next_window
")

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
