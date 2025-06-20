function _gg_stash -d 'Create a stash with all changes'
    gg with_root __gg_stash_inner $argv
end

function __gg_stash_inner
    git add .
    git stash
end
