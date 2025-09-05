function _gg_undo -d 'Move to previous point in the reflog'
    git reflog \
        | fzf \
        | string split --max 1 ' ' \
        | read -l commit
    or return

    git checkout $commit
end
