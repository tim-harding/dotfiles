if status is-interactive
    alias ls="exa --long --all --git --icons --header --no-user --time-style=long-iso --group-directories-first --level=2"
    alias update_all="sudo pacman -Syu --noconfirm; yay -Syu --noconfirm; cargo install-update -a; rustup update"
    function take_a_dub
        git add . && git commit -m $argv
    end
    alias vi='nvim'
    alias vim='nvim'
    fish_add_path /home/tim/Documents/personal/23/07/neophyte/target/release/
    alias start_neophyte "neophyte &; disown"
    set fish_greeting
    set --export TERM xterm-256color
    set --export EDITOR nvim
end

# Set default browser:
# xdg-settings set default-web-browser firefox.desktop
# Set the app to open a filetype example:
# xdg-mime default firefox.desktop application/pdf
# This line is a also helpful:
set --export BROWSER firefox.desktop

# set --export RUSTC_WRAPPER sccache
set --export RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/bin

# opam configuration
source /home/tim/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
