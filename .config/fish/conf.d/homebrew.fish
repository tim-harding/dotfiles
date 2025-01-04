switch $platform
    case darwin
        brew shellenv | source
end
set -xg HOMEBREW_BAT
set -xg HOMEBREW_NO_ENV_HINTS
set -xg HOMEBREW_NO_AUTO_UPDATE
