function update_mirrors
    set -l mirrorlist (curl 'https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=6&use_mirror_status=on' \
        1&| rg --only-matching -e "Server = .*")
    set mirrorlist "$(string join \n $mirrorlist)"
    set mirrorlist (string escape $mirrorlist)
    sudo fish -c "echo $mirrorlist >/etc/pacman.d/mirrorlist"
    sudo pacman -Syyuu
end
