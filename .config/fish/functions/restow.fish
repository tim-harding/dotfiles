function restow
    argparse c/clean -- $argv
    or return

    if set -q _flag_clean
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

    set -l dir ~/code/github.com/tim-harding/dotfiles
    test -d $dir
    or set dir ~/dotfiles

    stow --dir $dir --target ~ --no-folding --restow --adopt
end
