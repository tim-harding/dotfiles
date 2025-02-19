switch $platform
    case Linux
        set -xg VDPAU_DRIVER radeonsi
        set -xg LIBVA_DRIVER_NAME radeonsi
        set -xg GTK_THEME Adwaita:dark
        set -xg GTK2_RC_FILES /usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
        set -xg QT_STYLE_OVERRIDE Adwaita-Dark
        if test (tty) = /dev/tty1
            gsettings set org.gnome.desktop.interface color-scheme prefer-dark
            Hyprland
        end
end
