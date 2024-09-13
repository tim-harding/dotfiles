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
    --sort=modified \
    --reverse \
    $argv
end

function mkdir
    # Make intermediate directories automatically
    /usr/bin/env mkdir -p $argv
end

function sauce
    source ~/.config/fish/config.fish
end

function path_latest
    string join0 $argv | sort -z -V | tail -z -n 1
end

