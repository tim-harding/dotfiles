function restow
    pushd ~/dotfiles
    stow . --no-folding --restow --adopt
    popd

    for dir in ~/{.cargo,.config,.local,.ssh,Library}
        pushd $dir
        # Remove broken links
        fd --type symlink --follow --exec rm {}
        popd
    end

    pushd ~
    fd --max-depth 1 --type symlink --follow --exec rm {}
    popd
end
