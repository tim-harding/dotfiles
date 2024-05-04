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
    # Make intermediate directories automatically
    /usr/bin/env mkdir -p $argv
end

function sauce
    source ~/.config/fish/config.fish
end

function update_all
    switch (uname)
    case Linux
        sudo pacman -Syu --noconfirm
        yay -Syu --noconfirm
    case Darwin
        brew update
        brew upgrade
    end
    rustup update
    cargo install-update -a
    pyenv install $(pyenv latest 3) --skip-existing
    pipx upgrade-all
    bob update --all
    nvim --headless '+Lazy! sync' +qa
end

function git_root
    git rev-parse --show-toplevel
end

function with_git_root
    git_root | read root
    if [ $root = $(pwd) ]
        $argv
    else
        cd $root
        $argv
        prevd
    end
end

function take_a_dub
    function inner
        git add . 
        git commit -m $argv
    end
    set --prepend argv inner
    with_git_root $argv
end

function reset-hard
    function inner
        git add .
        git reset --hard
    end
    set --prepend argv inner
    with_git_root $argv
end

function amend
    function inner
        git add .
        git commit --amend --no-edit
    end
    set --prepend argv inner
    with_git_root $argv
end

function remove_orphan_packages
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end

function neo
    RUST_LOG="debug" RUST_BACKTRACE=1 ~/Documents/personal/neophyte/target/release/neophyte $argv &> ~/temp/neophyte_log.txt &
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

set --export RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/bin
fish_add_path ~/.dotnet/tools

# pipx completions
register-python-argcomplete --shell fish pipx | source

# opam configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set --export FLYCTL_INSTALL ~/.fly
fish_add_path $FLYCTL_INSTALL/bin

set --export BAT_PAGER
set --export FZF_DEFAULT_OPTS --reverse --inline-info

cp ~/.config/misc/.gitconfig ~/.gitconfig

switch (uname)
case Linux
    fish_ssh_agent

    set FIREFOX_DIR ~/.mozilla/firefox
    set FIREFOX_USER $(exa $FIREFOX_DIR | rg ".default\$")
    ln -sf ~/.config/misc/user.js "$FIREFOX_DIR/$FIREFOX_USER/user.js"
    set --export BROWSER firefox

case Darwin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
    fish_add_path "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"

    set TEALDEER_CONFIG_DIR ~/Library/Application\ Support/tealdeer
    set TEALDEER_CONFIG "$TEALDEER_CONFIG_DIR/config.toml"
    mkdir $TEALDEER_CONFIG_DIR 
    rm $TEALDEER_CONFIG 
    ln -s ~/.config/tealdeer/config.toml $TEALDEER_CONFIG
end

function initial-install
    switch (uname)
    case Linux
        xdg-settings set default-web-browser firefox.desktop
        xdg-mime default firefox.desktop application/pdf
    end
end
