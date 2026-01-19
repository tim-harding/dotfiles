function _gg_rebase -d 'Interactive rebase against common ancestor with trunk'
    set -l trunk (gg trunk)
    set -l merge_base (git merge-base HEAD $trunk)
    git rebase $merge_base --interactive
end
