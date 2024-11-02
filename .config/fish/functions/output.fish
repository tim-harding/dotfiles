# Function to manage Sway headless monitors for screen sharing
function output
    function current
        swaymsg -t get_outputs | jq -r '[.[].name | select(test("HEADLESS"))][0]'
    end

    switch $argv[1]
        case print
            echo $(current)

        case create
            argparse 'r/resolution=?' -- $argv[2..]
            or return
            if set -q _flag_r
                set _flag_r 1200x800
            end

            swaymsg create_output
            set current $(current)
            swaymsg output $current position 0 0
            swaymsg output $current resolution $_flag_r
            swaymsg output $current background \#232634 solid_color
            swaymsg workspace 0 output $current

        case delete
            swaymsg output $(current) unplug

        case show
            wl-mirror $(current) &
            disown

        case '*'
            return
    end
end
