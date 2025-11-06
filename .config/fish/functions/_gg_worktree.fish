function _gg_worktree --argument-names branch -d 'Create a new worktree'
    cd (git root)
    git fetch --all --prune
    git worktree prune

    set -l list_branches git for-each-ref \
        --format='%(refname:short)' \
        --sort='-committerdate'

    set -l local ($list_branches refs/heads)
    set -l remote (
        $list_branches refs/remotes/origin \
            | rg --invert-match '^origin$' \
            | string replace 'origin/' ''
    )

    if test -z $branch
        string join \n $local $remote | dedup | fzf | read branch
        or return
    end

    # Check if branch exists locally or on remote
    if not string match $branch --quiet -- $local
        if string match $branch --quiet -- $remote
            # Branch exists on remote, just use it
            echo "Branch $branch exists on origin, using remote branch"
        else
            # Branch doesn't exist locally or remotely, ask to create
            read -P "Create branch $branch? [y/N] " -n 1 response
            or return
            if not string match -qi y -- $response
                return
            end
            git branch $branch
        end
    end

    set -l dir (path normalize (gg worktree_root)/../$branch)

    git worktree add $dir $branch
    cd $dir
end
