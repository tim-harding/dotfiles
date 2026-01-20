function _gg_back -d 'edit last commit by stashing other changes'
    gg soft 1
    git all
    git stash push --keep-index --include-untracked
    gg soft
end
