function update_all
    update_platform
    fish --command "update_rust" &
    fish --command "update_neovim" &
    pyenv install $(pyenv latest 3) --skip-existing &
    fisher update &
    bun update --global &
    gem update &
    
    wait
end

function update_platform
    switch (uname)
    case Linux
        sudo pacman -Syu --noconfirm
        yay -Syu --noconfirm
    case Darwin
        brew update
        brew upgrade
    end
end

function update_neovim
    bob update --all
    nvim --headless '+Lazy! sync' +qa
end

function update_rust
    rustup update
    cargo install-update --all
end

