function pm_remove_orphans
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end
