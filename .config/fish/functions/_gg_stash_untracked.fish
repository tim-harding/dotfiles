function _gg_stash_untracked -d 'Stash changes keeping index and including untracked files'
    git stash push --keep-index --include-untracked
end
