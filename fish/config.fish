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

function sauce
    source ~/.config/fish/config.fish
end

function update_all
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
    rustup update
    cargo install-update -a
    code --list-extensions | xargs -I % code --install-extension % --force
end

function take_a_dub
    git add . 
    git commit -m $argv
end

function project
    cd $(fd $argv ~/Documents/personal --max-depth 3)
end

function neophyte
    RUST_LOG="debug" RUST_BACKTRACE=1 /home/tim/Documents/personal/23/07/neophyte/target/release/neophyte $argv &> /home/tim/temp/neophyte_log.txt &
    disown
end

function output_current
    swaymsg -t get_outputs | jq -r '[.[].name | select(test("HEADLESS"))][0]'
end

function output_create
    swaymsg create_output
    set current $(output_current)
    swaymsg output $current position 0 0
    swaymsg output $current resolution 1200x800
    swaymsg output $current background \#232634 solid_color
    swaymsg workspace 0 output $current
end

function output_show
    wl-mirror $(output_current) &
    disown
end

function output_delete
    swaymsg output $(output_current) unplug
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

fish_ssh_agent
