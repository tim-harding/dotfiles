function _gg_log --description "Commits since branching from trunk"
    git log --oneline --no-decorate --first-parent (gg trunk)..@
end
