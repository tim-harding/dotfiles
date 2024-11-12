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
    restow
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

    nix profile upgrade --all

    gup update

    rustup update stable
    cargo install-update --all

    fisher update
    bun update --global
    gem update

    bob update --all
    nvim '+Lazy sync' '+Lazy update' +qa &>/dev/null
end
