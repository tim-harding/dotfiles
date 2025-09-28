function _gg_worktree_root
    for d in (git worktree list --porcelain | rg 'worktree (.*)' --replace '$1')
        git -C $d rev-parse --absolute-git-dir
    end | rg '(.*)\/\.git$' --replace '$1'
end


