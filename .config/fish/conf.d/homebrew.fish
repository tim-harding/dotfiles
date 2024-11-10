switch $platform
    case darwin
        brew shellenv | source
end
set -x HOMEBREW_BAT
set -x HOMEBREW_NO_ENV_HINTS
set -x HOMEBREW_NO_AUTO_UPDATE
