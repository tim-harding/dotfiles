switch (uname)
case Linux
    if status --is-login
        systemctl --user start opentabletdriver.service --now
    end
    set --export VDPAU_DRIVER radeonsi
    set --export LIBVA_DRIVER_NAME radeonsi
end

