function _gg_worktree -d 'Create a new worktree'
    gg with_root __gg_worktree_inner $argv
end

function __gg_worktree_inner --argument-names branch
    git pull
    git worktree prune
    if not string match --regex ".*$branch.*" (git branch --list) > /dev/null
        git branch $branch
    end
    git worktree add ../$branch $branch
    cd ../$branch
end
