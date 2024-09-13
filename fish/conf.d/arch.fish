switch (uname)
case Linux
    systemctl --user start opentabletdriver.service --now
    set --export VDPAU_DRIVER radeonsi
    set --export LIBVA_DRIVER_NAME radeonsi
end

