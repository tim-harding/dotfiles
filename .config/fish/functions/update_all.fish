function update_all
    heading Dotfiles
    pushd ~/dotfiles
    while not git pull
        echo "Uncommitted config changes"
        echo "1) lazygit"
        echo "2) continue"
        echo "3) exit"
        read -P "Choice: " CHOICE
        switch $CHOICE
            case 1 lazygit
                lazygit
            case 2 continue
                break
            case 3 exit
                popd
                return
        end
    end
    restow --clean
    popd

    switch $platform
        case Linux
            heading Pacman
            sudo pacman -Syu --noconfirm
            paccache -rk1
            yay -Syu --noconfirm

            heading Hyprland plugins
            hyprpm update # Add -f to fix header issues
        case Darwin
            heading Software Update
            softwareupdate --install --all

            heading Homebrew
            brew update
            brew upgrade
    end

    if command -q nix
        heading Nix
        nix profile upgrade --all
    end

    if not command -q gup
        go install github.com/nao1215/gup@latest
    end
    if command -q gup
        heading Go programs
        gup update
    end

    if command -q rustup
        heading Rust
        rustup update stable

        heading Rust programs
        cargo install-update --all
    end

    if not functions -q fisher
        read -P "Fisher not found. Install? [y/N] " -n 1 response
        if string match -qi 'y' -- $response
            set -l fisher_url https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish
            curl -sL $fisher_url | source \
                && fisher install jorgebucaran/fisher
        end
    end
    if command -q fisher
        heading Fish plugins
        fisher update
    end

    if command -q bun
        heading Bun programs
        bun update --global --latest
    end

    if command -q npm
        heading NPM programs
        npm update --global
    end

    switch $platform
        case Linux
            set -l is_gem (command -q gem)
        case Darwin
            set -l is_gem (string match '*brew*' (which gem))
    end
    if set -q is_gem
        heading Ruby gems
        gem update
    end

    if command -q bob
        heading Neovim
        bob update --all
    end

    if command -q nvim
        heading Lazy plugins
        nvim '+Lazy sync' '+Lazy update' +qa &>/dev/null
    end

    if command -q turso
        heading Turso
        turso update
    end

    if command -q uv
        heading Python programs
        uv self update
        uv tool upgrade --all
    end

    if command -q cs
        heading Scala tooling
        cs update
    end

    # TODO: Figure out upgrading Luarocks. The command doesn't seem to have this
    # at the moment. Probably need something with `lua list --porcelain --outdated`
end