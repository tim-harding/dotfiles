function _gg_fixup -d 'Fix up previous commit'
    git log --oneline --no-decorate \
        | fzf \
        | string split --max 1 ' ' \
        | read -l commit
    or return

    git add
    git commit --fixup $argv
    git rebase (gg trunk) --autosquash
end
