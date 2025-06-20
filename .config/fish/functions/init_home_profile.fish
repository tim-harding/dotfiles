function init_home_profile
    set -g brew_extra_taps \
        libsql/sqld \
        omnisharp/omnisharp-roslyn \
        osx-cross/arm \
        osx-cross/avr \
        oven-sh/bun \
        qmk/qmk \
        tursodatabase/tap

    set -g brew_extra_formulae \
        claude \
        boost \
        qmk/qmk/qmk \
        xcbeautify \
        xcode-build-server \
        xcodegen \
        swiftformat \
        swiftlint \
        resvg \
        postgresql@14, restart_service: :changed \
        pkgconf \
        imagemagick \
        haskell-language-server \
        fourmolu \
        gh \
        ghcup \
        flyctl \
        ffmpeg \
        harfbuzz \
        gcc

    set -g brew_extra_casks \
        katrain
end
