function _gg_log --description "Commits since branching from trunk"
    git log --oneline --no-decorate (gg trunk)..HEAD
end
