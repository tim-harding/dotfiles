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
    bob update --all
    pyenv install $(pyenv latest 3) --skip-existing
    nvim --headless '+Lazy! sync' +qa
    fisher update
    cargo install-update --all
    npm update --global
    bun update --global
    gem update
end

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

