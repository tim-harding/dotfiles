switch $platform
    case Linux
        set --export VDPAU_DRIVER radeonsi
        set --export LIBVA_DRIVER_NAME radeonsi
        if test (tty) = /dev/tty1
            Hyprland
        end
end
