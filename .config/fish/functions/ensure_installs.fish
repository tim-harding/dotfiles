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
            brew bundle install --file ~/.config/brewfile/Brewfile
            # brew bundle install --file ~/.config/brewfile/Brewfile.$HOSTNAME
    end

    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv tool install ruff@latest

    # ls ~/go/bin
    go install github.com/nao1215/gup@latest
    go install golang.org/x/tools/gopls@latest
    go install github.com/google/yamlfmt/cmd/yamlfmt@latest

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
        vscode-langservers-extracted

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
        tokei

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
