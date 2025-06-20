function _gg_worktree -d 'Create a new worktree'
    function inner --argument-names branch
        git pull
        git worktree prune
        if not string match --regex ".*$branch.*" (git branch --list) > /dev/null
            git branch $branch
        end
        git worktree add ../$branch $branch
        cd ../$branch
    end
    gg with_root inner $argv
end
