function ls
    exa \
    --long \
    --all \
    --git \
    --icons \
    --header \
    --no-user \
    --time-style=long-iso \
    --group-directories-first \
    --level=2 \
    $argv
end

function mkdir
    /usr/bin/mkdir -p $argv
end

function sauce
    source ~/.config/fish/config.fish
end

function update_all
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
    rustup update
    cargo install-update -a
end

function take_a_dub
    git add . 
    git commit -m $argv
end

function project
    cd $(fd $argv /home/tim/Documents/personal --exact-depth 3)
end

complete -c project -x -a '(fd . /home/tim/Documents/personal --exact-depth 3 --exec printf "%s\n" {/})'

function neophyte
    RUST_LOG="debug" RUST_BACKTRACE=1 /home/tim/Documents/personal/23/07/neophyte/target/release/neophyte $argv &> /home/tim/temp/neophyte_log.txt &
    disown
end

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

set -l commands print create delete show
set -l create_command create
complete -c output --no-files
complete -c output -n "not __fish_seen_subcommand_from $commands" -a print -d 'Print the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a create -d 'Create a new output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a delete -d 'Delete the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a show -d 'Show the current output in a window'
complete -c output -n "__fish_seen_subcommand_from create" -a '-r --resolution'
complete -c output -s r -l resolution -ra '1200x800' -d 'Sets the output resolution'

function exercism_prolog_test
    set test_dir $(basename $PWD)
    swipl -t halt -g "[$test_dir]" -s {$test_dir}_tests.plt -g "run_tests" -- --all
end

alias vi='nvim'
alias vim='nvim'
set fish_greeting
set --export TERM xterm-256color
set --export EDITOR nvim

# Set default browser:
# xdg-settings set default-web-browser firefox.desktop
# Set the app to open a filetype example:
# xdg-mime default firefox.desktop application/pdf
# This line is a also helpful:
set --export BROWSER firefox

# set --export RUSTC_WRAPPER sccache
set --export RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/bin
fish_add_path ~/.dotnet/tools

# opam configuration
source /home/tim/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -x FLYCTL_INSTALL "/home/tim/.fly"
fish_add_path $FLYCTL_INSTALL/bin

fish_ssh_agent
