function restow
    argparse c/clean -- $argv
    or return

    if set -q _flag_clean
        # Remove broken symlinks
        fd --type symlink --hidden --follow --exec rm {}
    end

    stow --dir ~/code/github.com/tim-harding/dotfiles/main \
        --target ~ \
        --no-folding \
        --adopt \
        --restow .
end
