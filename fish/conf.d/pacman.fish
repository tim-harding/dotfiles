function remove_orphan_packages
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end

abbr --add pmq pacman -Qe
abbr --add pmu sudo pacman --noconfirm -Rs
abbr --add pmi sudo pacman --noconfirm -Syu
