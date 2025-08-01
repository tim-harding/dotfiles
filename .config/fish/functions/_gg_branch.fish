function _gg_branch -d 'Print the current branch name'
    git rev-parse --abbrev-ref HEAD
end
