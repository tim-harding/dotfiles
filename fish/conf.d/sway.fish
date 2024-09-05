# Adapted from https://gitlab.com/jokeyrhyme/dotfiles/-/blob/main/usr/local/bin/dotfiles-sway.sh
# Much of this is about fixing xdg-desktop-portal-wlr starting correctly

function start_sway
    set --export XDG_CURRENT_DESKTOP sway
    set --export XDG_SESSION_DESKTOP sway
    set --export XDG_SESSION_TYPE wayland
    sway
end

# If running from tty1 start sway
# set TTY1 (tty)
# [ "$TTY1" = "/dev/tty1" ] && start_sway
