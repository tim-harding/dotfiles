function ensure_installs
    # Todo: Also remove packages not listed
    # Todo: Include system packages

    if not command -q cargo
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    end

    switch $platform
        case Linux
            set -l binstall_url https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh
            curl -L --proto '=https' --tlsv1.2 -sSf $binstall_url | bash

        case Darwin
            init_local_profile

            if set -q brew_extra_taps
                brew tap $brew_extra_taps
            end

            brew install --formula $brew_extra_formulae \
                bottom \
                cmake \
                coreutils \
                coursier \
                fd \
                fish \
                fzf \
                git-delta \
                git-lfs \
                go \
                gum \
                jq \
                lazygit \
                lua-language-server \
                luarocks \
                neovim \
                pipx \
                ruff-lsp \
                sd \
                stow \
                syncthing \
                tinymist \
                typst \
                oven-sh/bun/bun \
                yarn \
                cargo-binstall \
                coursier/formulas/coursier \
                pyenv \
                bruno \
                node \
                scroll-reverser

            brew install --cask $brew_extra_casks \
                ghostty \
                karabiner-elements \
                keepassxc \
                font-cascadia-code \
                font-cascadia-code-pl \
                docker \
                hammerspoon \
                chatgpt \
                jdk-mission-control
    end

    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv tool install ruff@latest pyright@latest

    # ls ~/go/bin
    for pkg in \
        github.com/nao1215/gup \
        golang.org/x/tools/gopls \
        github.com/google/yamlfmt/cmd/yamlfmt \
        github.com/joyme123/thrift-ls \
        github.com/sqlc-dev/sqlc/cmd/sqlc \
        github.com/golangci/golangci-lint

        go install $pkg@latest
    end

    # bun pm ls -g
    bun install --global \
        @anthropic-ai/claude-code \
        @bitwarden/cli \
        @fsouza/prettierd \
        @shopify/cli \
        @vtsls/language-server \
        @vue/language-server \
        eslint \
        prettier \
        typescript \
        typescript-language-server \
        vscode-langservers-extracted \
        @biomejs/biome

    # cargo install --list
    cargo binstall \
        bat \
        cargo-expand \
        cargo-update \
        cargo-upgrades \
        create-tauri-app \
        du-dust \
        eza \
        fd-find \
        flamegraph \
        ripgrep \
        sd \
        tealdeer \
        tokei \
        protols \
        jj-cli

    cs install \
        ammonite \
        bloop \
        coursier \
        cs \
        metals \
        sbt \
        sbtn \
        scala \
        scala-cli \
        scalac \
        scalafix \
        scalafmt
end
