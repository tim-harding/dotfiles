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
            paccache -rk1
            yay -Syu --noconfirm
            hyprpm update # Add -f to fix header issues
        case Darwin
            softwareupdate --install --all
            brew update
            brew upgrade
    end

    if command -q nix
        nix profile upgrade --all
    end

    if command -q gup
        gup update
    end

    if command -q rustup
        rustup update stable
        cargo install-update --all
    end

    if not functions -q fisher; and gum confirm "Fisher not found. Install?"
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source \
            && fisher install jorgebucaran/fisher
    end
    if command -q fisher
        fisher update
    end

    if command -q bun
        bun update --global --latest
    end

    switch $platform
        case Linux
            set -l is_gem (command -q gem)
        case Darwin
            set -l is_gem (string match '*brew*' (which gem))
    end
    if set -q is_gem
        gem update
    end

    if command -q bob
        bob update --all
    end

    if command -q nvim
        nvim '+Lazy sync' '+Lazy update' +qa &>/dev/null
    end

    if command -q turso
        turso update
    end

    # TODO: Figure out upgrading Luarocks. The command doesn't seem to have this
    # at the moment. Probably need something with `lua list --porcelain --outdated`
end
