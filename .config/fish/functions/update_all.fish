function update_all
    pushd ~/dotfiles
    while not git pull
        gum choose --header "Uncommited config changes" lazygit continue exit | read CHOICE
        switch $CHOICE
            case lazygit
                lazygit
            case continue
                break
            case exit
                popd
                return
        end
    end
    stow . --no-folding
    popd

    switch $platform
        case Linux
            sudo pacman -Syu --noconfirm
            yay -Syu --noconfirm
        case Darwin
            softwareupdate --install --all
            brew update
            brew upgrade
    end

    rustup update stable
    cargo install-update --all

    fisher update
    bun update --global
    gem update

    bob update --all
    nvim '+Lazy update' +qa &>/dev/null
end
