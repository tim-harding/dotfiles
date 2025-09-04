function _gg_log --description "Commits since branching from trunk"
    git log --oneline (gg trunk)..HEAD
end
