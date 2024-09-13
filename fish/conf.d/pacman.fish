function remove_orphan_packages
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end
