if status is-interactive
    alias ls="exa --long --all --git --icons --header --no-user --time-style=long-iso --group-directories-first --level=2"
    function take_a_dub
        git add . && git commit -m $argv
    end
    alias vi='nvim'
    alias vim='nvim'
    set fish_greeting
    set -x TERM xterm-256color
    set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
    set -x EDITOR nvim
    fish_add_path ~/.cargo/bin
end

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/home/tim/.config/netlify/helper/path.fish.inc' && source '/home/tim/.config/netlify/helper/path.fish.inc'
