if status is-interactive
    alias ls="exa --long --all --git --icons --header --no-permissions --no-user --time-style=long-iso --group-directories-first --level=2"
    set -x TERM xterm-256color
end
