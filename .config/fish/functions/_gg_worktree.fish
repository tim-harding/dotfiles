function _gg_worktree --argument-names branch -d 'Create a new worktree'
    cd (git root)
    git fetch --all --prune
    git worktree prune

    set -l list_branches git for-each-ref \
        --format='%(refname:short)' \
        --sort='-committerdate'

    set -l local ($list_branches refs/heads)

    if test -z $branch
        set -l remote (
            $list_branches refs/remotes/origin \
                | rg --invert-match '^origin$' \
                | string replace 'origin/' ''
        )
        string join \n $local $remote | dedup | fzf | read branch
        or return
    else if not string match $branch --quiet -- $local
        gum confirm "Create branch $branch?"
        or return
        git branch $branch
    end

    set -l dir (path normalize (gg root_worktree)/../$branch)

    git worktree add $dir $branch
    cd $dir
end
