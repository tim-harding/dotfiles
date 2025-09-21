function _gg_fixup -d 'Fix up previous commit'
    git log --oneline --no-decorate \
        | fzf \
        | string split --max 1 ' ' \
        | read -l commit
    or return

    git all
    git commit --fixup $argv
    git rebase (gg trunk) --autosquash
end
