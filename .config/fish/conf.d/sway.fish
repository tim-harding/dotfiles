# Adapted from https://gitlab.com/jokeyrhyme/dotfiles/-/blob/main/usr/local/bin/dotfiles-sway.sh
# Much of this is about fixing xdg-desktop-portal-wlr starting correctly

if test (tty) = /dev/tty1
    sway_start
end
