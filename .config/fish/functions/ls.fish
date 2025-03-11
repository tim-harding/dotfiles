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
        $argv
end
