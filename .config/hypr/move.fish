#!/usr/bin/env -S fish --no-config

set -l win (hyprctl activewindow -j)
set -l grp_len (echo $win | jq '.grouped | length')

if test $grp_len -eq 0
    if test (echo $win | jq '.fullscreen > 0') = true
        switch $argv
            case l
                if test (echo $win | jq '.monitor == 1') = true
                    hyprctl dispatch workspace -1
                else
                    hyprctl dispatch movefocus $argv
                end
            case r
                if test (echo $win | jq '.monitor == 0') = true
                    hyprctl dispatch workspace 1
                else
                    hyprctl dispatch movefocus $argv
                end
        end
    else
        hyprctl dispatch movefocus $argv
    end
else
    set -l grp_idx (echo $win | jq '.address as $addr | .grouped | index($addr)')
    switch $argv
        case l
            if test $grp_idx -eq 0
                hyprctl dispatch movefocus l
            else
                hyprctl dispatch changegroupactive b
            end
        case r
            if test $grp_idx -eq (math $grp_len - 1)
                hyprctl dispatch movefocus r
            else
                hyprctl dispatch changegroupactive f
            end
    end
end
