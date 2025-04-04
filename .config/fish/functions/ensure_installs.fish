function ensure_installs
    # Todo: Also remove packages not listed
    # Todo: Include system packages

    switch $platform
        case Linux
            set -l binstall_url https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh
            curl -L --proto '=https' --tlsv1.2 -sSf $binstall_url | bash
        case Darwin
            brew bundle install --file ~/.config/brewfile/Brewfile
            # brew bundle install --file ~/.config/brewfile/Brewfile.$HOSTNAME
    end

    go install \
        github.com/nao1215/gup@latest \
        golang.org/x/tools/gopls@latest

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
end
