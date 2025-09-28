function _gg_worktree_dir -a branch -d 'Show the worktree directory for a branch'
    git worktree list --porcelain \
        | awk -v br="refs/heads/$branch" '
            $1=="worktree" { wt=$2 }
            $1=="branch" && $2==br { print wt }'
end


