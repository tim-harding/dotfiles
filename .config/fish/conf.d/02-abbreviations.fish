abbr copy fish_clipboard_copy
abbr paste fish_clipboard_paste
abbr mkdir mkdir -p
abbr rgg rg --hidden --follow --glob "!.git"
abbr fdd fd --hidden
abbr remove_broken_links fd --type symlink --follow --exec rm {}
abbr restow stow . --no-folding --restow --adopt
abbr --add pmq pacman -Qe
abbr --add pmi sudo pacman --noconfirm -Syu
abbr --add pmu sudo pacman --noconfirm -Rs
abbr --add yayi yay --noconfirm -Syu
abbr --add yayu yay --noconfirm -Rs
