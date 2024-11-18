#!/usr/bin/env -S fish --no-config

set -l win (hyprctl activewindow -j)
set -l grp_len (echo $win | jq '.grouped | length')

if test $grp_len -eq 0
    hyprctl dispatch movewindoworgroup $argv
else
    set -l grp_idx (echo $win | jq '.address as $addr | .grouped | index($addr)')
    switch $argv
        case l
            if test $grp_idx -eq 0
                hyprctl dispatch movewindoworgroup l
            else
                hyprctl dispatch movegroupwindow b
            end
        case r
            if test $grp_idx -eq (math $grp_len - 1)
                hyprctl dispatch movewindoworgroup r
            else
                hyprctl dispatch movegroupwindow f
            end
    end
end
