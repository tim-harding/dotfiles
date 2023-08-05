if status is-interactive
    alias ls="exa --long --all --git --icons --header --no-user --time-style=long-iso --group-directories-first --level=2"
    function take_a_dub
        git add . && git commit -m $argv
    end
    alias vi='nvim'
    alias vim='nvim'
    set fish_greeting
    set --export TERM xterm-256color
    set --export EDITOR nvim
end
set --export RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
fish_add_path ~/.cargo/bin
