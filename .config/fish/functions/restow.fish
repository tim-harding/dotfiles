function restow
    pushd ~/dotfiles
    stow . --no-folding --restow --adopt
    popd

    pushd ~
    fd --type symlink --follow --exec rm {}
    popd
end
