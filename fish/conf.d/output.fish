function output
    function current
        swaymsg -t get_outputs | jq -r '[.[].name | select(test("HEADLESS"))][0]'
    end

    switch $argv[1]
    case 'print'
        echo $(current)

    case 'create'
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

    case 'delete'
        swaymsg output $(current) unplug

    case 'show'
        wl-mirror $(current) &
        disown

    case '*'
        return
    end
end

if status --is-interactive
    set -l commands print create delete show
    set -l create_command create
    complete -c output --no-files
    complete -c output -n "not __fish_seen_subcommand_from $commands" -a print -d 'Print the current output'
    complete -c output -n "not __fish_seen_subcommand_from $commands" -a create -d 'Create a new output'
    complete -c output -n "not __fish_seen_subcommand_from $commands" -a delete -d 'Delete the current output'
    complete -c output -n "not __fish_seen_subcommand_from $commands" -a show -d 'Show the current output in a window'
    complete -c output -n "__fish_seen_subcommand_from create" -a '-r --resolution'
    complete -c output -s r -l resolution -ra '1200x800' -d 'Sets the output resolution'
end
