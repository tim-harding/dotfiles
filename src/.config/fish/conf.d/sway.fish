# Adapted from https://gitlab.com/jokeyrhyme/dotfiles/-/blob/main/usr/local/bin/dotfiles-sway.sh
# Much of this is about fixing xdg-desktop-portal-wlr starting correctly

function sway_start
    set --export XDG_CURRENT_DESKTOP sway
    set --export XDG_SESSION_DESKTOP sway
    set --export XDG_SESSION_TYPE wayland
    sway
end

if test (tty) = /dev/tty1
    sway_start
end
