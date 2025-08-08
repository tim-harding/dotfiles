function update_all
    __update_all_heading Dotfiles
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
    restow --clean
    popd

    switch $platform
        case Linux
            __update_all_heading Pacman
            sudo pacman -Syu --noconfirm
            paccache -rk1
            yay -Syu --noconfirm

            __update_all_heading Hyprland plugins
            hyprpm update # Add -f to fix header issues
        case Darwin
            __update_all_heading Software Update
            softwareupdate --install --all

            __update_all_heading Homebrew
            brew update
            brew upgrade
    end

    if command -q nix
        __update_all_heading Nix
        nix profile upgrade --all
    end

    if command -q gup
        __update_all_heading Go programs
        gup update
    end

    if command -q rustup
        __update_all_heading Rust
        rustup update stable

        __update_all_heading Rust programs
        cargo install-update --all
    end

    if not functions -q fisher; and gum confirm "Fisher not found. Install?"
        set -l fisher_url https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish
        curl -sL $fisher_url | source \
            && fisher install jorgebucaran/fisher
    end
    if command -q fisher
        __update_all_heading Fish plugins
        fisher update
    end

    if command -q bun
        __update_all_heading Bun programs
        bun update --global --latest
    end

    if command -q npm
        __update_all_heading NPM programs
        npm update --global
    end

    switch $platform
        case Linux
            set -l is_gem (command -q gem)
        case Darwin
            set -l is_gem (string match '*brew*' (which gem))
    end
    if set -q is_gem
        __update_all_heading Ruby gems
        gem update
    end

    if command -q bob
        __update_all_heading Neovim
        bob update --all
    end

    if command -q nvim
        __update_all_heading Lazy plugins
        nvim '+Lazy sync' '+Lazy update' +qa &>/dev/null
    end

    if command -q turso
        __update_all_heading Turso
        turso update
    end

    if command -q uv
        __update_all_heading Python programs
        uv self update
        uv tool upgrade --all
    end

    if command -q cs
        __update_all_heading Scala tooling
        cs update
    end

    # TODO: Figure out upgrading Luarocks. The command doesn't seem to have this
    # at the moment. Probably need something with `lua list --porcelain --outdated`
end

function __update_all_heading
    gum style \
        --border rounded \
        --padding "0 1" \
        "$argv"
end
