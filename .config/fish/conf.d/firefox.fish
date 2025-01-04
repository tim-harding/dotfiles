switch $platform
    case Linux
        set -xg BROWSER firefox
        set -xg MOZ_ENABLE_WAYLAND 1
        set -xg MOZ_WEBRENDER 1
end
