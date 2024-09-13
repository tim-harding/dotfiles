function pm_remove_orphans
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end

abbr --add pmq pacman -Qe
abbr --add pmu sudo pacman --noconfirm -Rs
abbr --add pmi sudo pacman --noconfirm -Syu
