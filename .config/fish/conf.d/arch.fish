switch $platform
    case Linux
        set -xg VDPAU_DRIVER radeonsi
        set -xg LIBVA_DRIVER_NAME radeonsi
        if test (tty) = /dev/tty1
            Hyprland
        end
end
