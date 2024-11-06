function restow
    pushd ~/dotfiles
    stow . --no-folding --restow --adopt
    popd

    argparse c/clean -- $argv
    or return

    if not set -q _flag_clean
        return
    end

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
